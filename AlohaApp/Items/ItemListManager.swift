//
//  ItemListManager.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/20/25.
//

import Foundation
import Firebase

public protocol DependentItemListManager: AnyObject {
    func dependentItemDeleted(_ item: any Item)
}

@Observable
public class ItemListManager<T: Item> {
    public private(set) var dependentItemListManagers = [any DependentItemListManager]()
    
    public var itemsByUUID = [String: T]()
    
    public var items: [T] {
        itemsByUUID.values.sorted(by: T.sort)
    }
    
    @ObservationIgnored
    private var pendingDeleteUUIDs = Set<String>()

    @ObservationIgnored
    private var refHandle: DatabaseHandle?
    
    private static var ref: DatabaseReference {
        Database.database().reference(withPath: T.refPath)
    }

    public func registerDependentItemListManager(_ dependentItemListManager: any DependentItemListManager) {
        dependentItemListManagers.append(dependentItemListManager)
    }
    
    public func startFetchingItems() {
        guard refHandle == nil else { return }
        refHandle = Self.ref.observe(DataEventType.value, with: { snapshot in
            let itemsData = (snapshot.valueAsDictionary as? [String: [String: Any]]) ?? [:]
            for (itemUUID, itemData) in itemsData {
                guard !self.pendingDeleteUUIDs.contains(itemUUID) else {
                    continue
                }
                var itemAsDictionary = itemData
                itemAsDictionary["uuid"] = itemUUID
                let item = T.fromDictionary(itemAsDictionary)!
                let existingItem = self.itemsByUUID[itemUUID]
                if let existingItem {
                    // Update existing item
                    DispatchQueue.main.async {
                        existingItem.update(from: item)
                    }
                } else {
                    // This is a new item
                    DispatchQueue.main.async {
                        self.itemsByUUID[itemUUID] = item
                    }
                }
            }
            
            // Delete clients if needed
            let itemUUIDs = Set(itemsData.keys)
            let existingItemUUIDs = Set(self.itemsByUUID.keys)
            let itemUUIDsToDelete = existingItemUUIDs.subtracting(itemUUIDs)
            DispatchQueue.main.async {
                for itemUUID in itemUUIDsToDelete {
                    self.itemsByUUID.removeValue(forKey: itemUUID)
                }
            }
            
            // Cleanup pending deletes if able
            let pendingDeleteUUIDsToCleanup = self.pendingDeleteUUIDs.subtracting(itemUUIDs)
            for itemUUID in pendingDeleteUUIDsToCleanup {
                self.pendingDeleteUUIDs.remove(itemUUID)
            }
        })
    }
    
    public func delete(_ item: T) {
        pendingDeleteUUIDs.insert(item.uuid)
        DispatchQueue.main.async {
            self.itemsByUUID.removeValue(forKey: item.uuid)
        }
        Self.ref.child(item.uuid).removeValue()
        // TODO: If the app crashes right here we will have items that aren't cleaned up
        for dependentItemListManager in dependentItemListManagers {
            dependentItemListManager.dependentItemDeleted(item)
        }
    }
    
    public func save(_ item: T) {
        self.itemsByUUID[item.uuid] = item
        Self.ref.child(item.uuid).updateChildValues(item.toDictionary())
    }
}

public class ChecklistItemListManager: ItemListManager<Checklist>, DependentItemListManager {
    public func dependentItemDeleted(_ item: any Item) {
        guard let inventoryItem = item as? InventoryItem else { return }
        
        for checklist in itemsByUUID.values {
            if checklist.quantityByItemUUID.removeValue(forKey: inventoryItem.uuid) != nil {
                save(checklist)
            }
        }
    }
}
