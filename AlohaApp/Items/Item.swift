//
//  Item.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 5/25/25.
//

import Foundation

public protocol Sortable {
    static func sort(lhs: Self, rhs: Self) -> Bool
}

public protocol Updateable {
    @MainActor
    func update(from other: Self)
}

public protocol Item: Codable, Hashable, Sortable, Updateable {
    static var refPath: String { get }
    
    static var name: String { get }
    
    static func newItem() -> Self
    
    var uuid: String { get }
    
    func isValid() -> Bool
    
    static func fromDictionary(_ dict: [String: Any]) -> Self?
    
    func toDictionary() -> [String: Any]
}

public extension Item {
    @MainActor
    func updateIfDifferent<T: Equatable>(_ current: inout T, newValue: T) {
        if current != newValue {
            current = newValue
        }
    }
}

public extension Item {
    static func _fromDictionary(_ dict: [String: Any]) -> Self? {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let data = try JSONSerialization.data(withJSONObject: dict)
            let instance = try decoder.decode(Self.self, from: data)
            return instance
        } catch {
            print(error)
        }
        return nil
    }
    
    static func fromDictionary(_ dict: [String: Any]) -> Self? {
        return _fromDictionary(dict)
    }
    
    func toDictionary() -> [String: Any] {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        guard let data = try? encoder.encode(self),
              let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return [:]
        }
        return dict
    }
}
