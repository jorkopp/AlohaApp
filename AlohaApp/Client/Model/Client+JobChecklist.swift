//
//  Client+JobChecklist.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 5/26/25.
//

import Foundation

extension Client {
    struct JobChecklist: Codable, Equatable, Hashable {
        var items: [ChecklistItem] = []
        var sortedItems: [ChecklistItem] {
            items.sorted { $0.name < $1.name }
        }
    }
    
    struct ChecklistItem: Codable, Equatable, Hashable {
        var name: String = ""
        var category: String = ""
        var quantity: String = ""
    }
}
