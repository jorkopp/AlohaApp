//
//  InventoryItem+Model.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import Foundation
import FirebaseFirestore

extension InventoryItem {
    struct Model: Item {
        static var name = "item"
        static var collectionPath = "inventoryItems"
        
        @DocumentID var id: String?
        var name: String = ""
        var category: String = ""
        var price: Float = 0
        var count: String = ""
        
        static func newItem() -> Model { Model() }
        
        static func sort(lhs: Model, rhs: Model) -> Bool {
            return lhs.name < rhs.name
        }
    }
}
