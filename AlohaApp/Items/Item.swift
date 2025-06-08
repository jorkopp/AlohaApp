//
//  Item.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 5/25/25.
//

import Foundation
import FirebaseFirestore

protocol Sortable {
    static func sort(lhs: Self, rhs: Self) -> Bool
}

protocol Item: Identifiable, Codable, Hashable, Sortable {
    static var collectionPath: String { get }
    
    var id: String? { get }
    
    static func newItem() -> Self
}
