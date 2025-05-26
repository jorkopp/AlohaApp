//
//  ChecklistItem.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import Foundation
import Firebase

@Observable
final public class ChecklistItem: Item, Codable, Hashable {
    public static var refPath = "checklistItems"
    
    public var uuid: String
    
    public var inventoryItem: InventoryItem?
    public var quantity: Int
    
    enum CodingKeys: String, CodingKey {
        case uuid, inventoryItem, quantity
    }
    
    public init(uuid: String, inventoryItem: InventoryItem?, quantity: Int) {
        self.uuid = uuid
        self.inventoryItem = inventoryItem
        self.quantity = quantity
    }
    
    public static func newItem() -> ChecklistItem {
        ChecklistItem(uuid: UUID().uuidString, inventoryItem: nil, quantity: 0)
    }
    
    public func isValid() -> Bool {
        inventoryItem != nil
    }
    
    // MARK: Sortable
    
    public static func sort(lhs: ChecklistItem, rhs: ChecklistItem) -> Bool {
        // TODO: Probably want to store a date and sort with that?
        return lhs.uuid < rhs.uuid
    }
    
    // MARK: Hashable
    
    public static func == (lhs: ChecklistItem, rhs: ChecklistItem) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    
    // MARK: Codable
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.uuid = try container.decode(String.self, forKey: .uuid)
        self.inventoryItem = try container.decode(InventoryItem.self, forKey: .inventoryItem)
        self.quantity = try container.decode(Int.self, forKey: .quantity)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uuid, forKey: .uuid)
        try container.encode(inventoryItem, forKey: .inventoryItem)
        try container.encode(quantity, forKey: .quantity)

    }
    
    // MARK: Updateable
    
    @MainActor
    public func update(from other: ChecklistItem) {
        updateIfDifferent(&inventoryItem, newValue: other.inventoryItem)
        updateIfDifferent(&quantity, newValue: other.quantity)
    }
}
