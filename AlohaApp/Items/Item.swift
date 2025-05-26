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

public protocol Referenceable {
    static var refPath: String { get }
}

public protocol DictionaryRepresenting: Codable {
    func toDictionary() -> [String: Any]
    static func fromDictionary(_ dict: [String: Any]) -> Self?
}

public extension DictionaryRepresenting {
    func toDictionary() -> [String: Any] {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        guard let data = try? encoder.encode(self),
              let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return [:]
        }
        return dict
    }
    
    static func fromDictionary(_ dict: [String: Any]) -> Self? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = try? JSONSerialization.data(withJSONObject: dict),
              let instance = try? decoder.decode(Self.self, from: data) else {
            return nil
        }
        return instance
    }
}

public protocol Updateable {
    @MainActor
    func update(from other: Self)
}

public extension Updateable {
    @MainActor
    func updateIfDifferent<T: Equatable>(_ current: inout T, newValue: T) {
        if current != newValue {
            current = newValue
        }
    }
}

public protocol UUIDConvertible {
    var uuid: String { get }
}

public protocol Item: UUIDConvertible & Sortable & Referenceable & DictionaryRepresenting & Updateable & Hashable {
    static func newItem() -> Self
    func isValid() -> Bool
}
