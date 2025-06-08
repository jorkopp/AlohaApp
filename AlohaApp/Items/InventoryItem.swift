//
//  InventoryItem.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import Foundation
import FirebaseFirestore

struct InventoryItem: Item {
    static var collectionPath = "inventoryItems"
    
    @DocumentID var id: String?
    
    var name: String = ""
    var price: Float = 0
    var count: String = ""
    
    static func newItem() -> InventoryItem {
        InventoryItem()
    }
    
    // MARK: Sortable
    
    static func sort(lhs: InventoryItem, rhs: InventoryItem) -> Bool {
        return lhs.name < rhs.name
    }
}
