////
////  Checklist.swift
////  AlohaApp
////
////  Created by Jordan Kopp on 5/26/25.
////
//
//import Foundation
//
//@Observable
//final public class Checklist: Item, Codable, Hashable {
//    public static var refPath = "checklists"
//    
//    public static var name = "checklist"
//    
//    public var uuid: String
//    
//    public var name: String
//    public var quantityByItemUUID: [String: String]
//    
//    enum CodingKeys: String, CodingKey {
//        case uuid
//        case name
//        case quantityByItemUUID = "quantityByItemUuid"
//    }
//    
//    public init(uuid: String, name: String, quantityByItemUUID: [String: String]) {
//        self.uuid = uuid
//        self.name = name
//        self.quantityByItemUUID = quantityByItemUUID
//    }
//    
//    public static func newItem() -> Checklist {
//        Checklist(uuid: UUID().uuidString, name: "Untitled", quantityByItemUUID: [:])
//    }
//    
//    public func isValid() -> Bool {
//        return !name.isEmpty
//    }
//    
//    // MARK: Sortable
//    
//    public static func sort(lhs: Checklist, rhs: Checklist) -> Bool {
//        return lhs.name < rhs.name
//    }
//    
//    // MARK: Hashable
//    
//    public static func == (lhs: Checklist, rhs: Checklist) -> Bool {
//        lhs.uuid == rhs.uuid
//    }
//    
//    public func hash(into hasher: inout Hasher) {
//        hasher.combine(ObjectIdentifier(self))
//    }
//    
//    // MARK: Codable
//    
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.uuid = try container.decode(String.self, forKey: .uuid)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.quantityByItemUUID = try container.decodeIfPresent(Dictionary.self, forKey: .quantityByItemUUID) ?? [:]
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(uuid, forKey: .uuid)
//        try container.encode(name, forKey: .name)
//        try container.encode(quantityByItemUUID, forKey: .quantityByItemUUID)
//    }
//    
//    public static func fromDictionary(_ dict: [String: Any]) -> Checklist? {
//        var updatedDict = dict
//        
//        // Firebase -> Swift workaround
//        if let quantityByItemUUID = dict["quantity_by_item_uuid"] as? [String: Any] {
//            var convertedQuantityByItemUUID = [String: String]()
//            for (key, value) in quantityByItemUUID {
//                convertedQuantityByItemUUID[key] = String(describing: value)
//            }
//            updatedDict["quantity_by_item_uuid"] = convertedQuantityByItemUUID
//        }
//        
//        return _fromDictionary(updatedDict)
//    }
//    
//    // MARK: Updateable
//    
//    @MainActor
//    public func update(from other: Checklist) {
//        updateIfDifferent(&name, newValue: other.name)
//        updateIfDifferent(&quantityByItemUUID, newValue: other.quantityByItemUUID)
//    }
//}
