//
//  ItemListManager.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/20/25.
//

import Foundation
import FirebaseFirestore

@Observable
class ItemListManager<T: Item> {
    var items: [T] {
        unsortedItems.sorted(by: T.sort)
    }
    
    private var unsortedItems = [T]()

    private let db = Firestore.firestore()
    @ObservationIgnored
    private var listener: ListenerRegistration?
    
    func startFetchingItems() {
        guard listener == nil else { return }
        listener = db.collection(T.collectionPath).addSnapshotListener { snapshot, error in
            guard let snapshot else {
                if let error {
                    print("Error fetching collection '\(T.collectionPath)': \(error)")
                }
                return
            }
            
            let updatedUnsortedItems = snapshot.documents.compactMap { doc in
                do {
                    return try doc.data(as: T.self)
                } catch {
                    print("Error decoding document for collection \(T.collectionPath): \(error)")
                    return nil
                }
            }
            
            DispatchQueue.main.async {
                self.unsortedItems = updatedUnsortedItems
            }
        }
    }
    
    func delete(_ item: T) {
        guard let itemID = item.id else {
            return
        }
        let documentRef = db.collection(T.collectionPath).document(itemID)
        documentRef.delete { error in
            if let error {
                print("Error deleting \(String(describing: T.self)): \(error)")
            } else {
                print("\(String(describing: T.self)) successfully deleted")
            }
        }
    }
    
    func save(_ newItem: T) {
        do {
            let documentReference = try db.collection(T.collectionPath).addDocument(from: newItem)
            print("Added document with ID: \(documentReference.documentID)")
        } catch {
            print("Error adding new \(String(describing: T.self)): \(error)")
        }
    }
    
    func update(_ item: T) {
        guard let itemID = item.id else {
            return
        }
        do {
            try db.collection(T.collectionPath).document(itemID).setData(from: item)
        } catch {
            print("Error updating \(String(describing: T.self)): \(error)")
        }
    }
    
    deinit {
        listener?.remove()
    }
}
