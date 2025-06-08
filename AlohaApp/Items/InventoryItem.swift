//
//  InventoryItem.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import Foundation

@Observable
final public class InventoryItem: Item, Codable, Hashable {
    public static var refPath = "inventoryItems"
    
    public static var name = "item"
    
    public var uuid: String
    
    public var name: String
    public var price: Float
    public var count: String
    
    enum CodingKeys: String, CodingKey {
        case uuid, name, price, count
    }
    
    public init(uuid: String, name: String, price: Float, count: String) {
        self.uuid = uuid
        self.name = name
        self.price = price
        self.count = count
    }
    
    public static func newItem() -> InventoryItem {
        InventoryItem(uuid: UUID().uuidString, name: "", price: 0, count: "")
    }
    
    // TODO: Some alert like this when not valid
    /*
     self.alert("Missing Information", isPresented: isPresented) {
         Button("OK", role: .cancel) { }
     } message: {
         Text("Inventory item must have a name to save.")
     }
     */
    // TODO: Should also have a make valid call to convert count="" to count="0" because we don't want to initialize it to 0 since for new items we don't want the user to have to backspace but if they save without it should default then
    public func isValid() -> Bool {
        !name.isEmpty
    }
    
    // MARK: Sortable
    
    public static func sort(lhs: InventoryItem, rhs: InventoryItem) -> Bool {
        return lhs.uuid < rhs.uuid
    }
    
    // MARK: Hashable
    
    public static func == (lhs: InventoryItem, rhs: InventoryItem) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    
    // MARK: Codable
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.uuid = try container.decode(String.self, forKey: .uuid)
        self.name = try container.decode(String.self, forKey: .name)
        self.price = try container.decode(Float.self, forKey: .price)
        self.count = try container.decode(String.self, forKey: .count)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uuid, forKey: .uuid)
        try container.encode(name, forKey: .name)
        try container.encode(price, forKey: .price)
        try container.encode(count, forKey: .count)

    }
    
    // MARK: Updateable
    
    @MainActor
    public func update(from other: InventoryItem) {
        updateIfDifferent(&name, newValue: other.name)
        updateIfDifferent(&price, newValue: other.price)
        updateIfDifferent(&count, newValue: other.count)
    }
}
