//
//  InventoryItemRowView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 5/25/25.
//

import Foundation
import SwiftUI

extension InventoryItem {
    @MainActor
    struct RowView: View {
        let inventoryItemModel: Model
        
        var body: some View {
            LabeledContent(inventoryItemModel.name) {
                Text(String(inventoryItemModel.count))
            }
        }
    }
}

#Preview {
    InventoryItem.RowView(inventoryItemModel: InventoryItem.Model(name: "Test Item", count: "10"))
}
