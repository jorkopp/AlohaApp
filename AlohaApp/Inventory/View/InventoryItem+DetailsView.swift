//
//  InventoryItem+DetailsView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 5/25/25.
//

import Foundation
import SwiftUI

extension InventoryItem {
    @MainActor
    struct DetailsView: View {
        @Environment(\.editMode) private var editMode
        
        private var isEditing: Bool {
            editMode?.wrappedValue.isEditing ?? false
        }
        
        @Binding var inventoryItemModel: Model
        
        var body: some View {
            Form {
                nameField("Name")
                countField("Count")
            }
        }
        
        @ViewBuilder
        func nameField(_ label: String) -> some View {
            if isEditing {
                LabeledTextField(label: label, placeholder: "e.g. Valve", value: $inventoryItemModel.name)
            } else {
                LabeledContent(label) {
                    Text(inventoryItemModel.name)
                }
            }
        }
        
        @ViewBuilder
        func countField(_ label: String) -> some View {
            if isEditing {
                LabeledNumberField(label: label, placeholder: "e.g. 5", value: $inventoryItemModel.count)
            } else {
                LabeledContent(label) {
                    Text(inventoryItemModel.count)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
