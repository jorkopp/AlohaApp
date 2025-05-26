//
//  InventoryItemRowView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 5/25/25.
//

import SwiftUI

@MainActor
struct InventoryItemRowView: View {
    let inventoryItem: InventoryItem
    
    var body: some View {
        LabeledContent(inventoryItem.name) {
            Text(String(inventoryItem.count))
        }
    }
}

