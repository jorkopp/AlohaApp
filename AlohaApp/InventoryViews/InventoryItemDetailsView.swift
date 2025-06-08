//
//  InventoryItemDetailsView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 5/25/25.
//

import SwiftUI

@MainActor
struct InventoryItemDetailsView: View {
    @Environment(\.editMode) private var editMode
    
    private var isEditing: Bool {
        editMode?.wrappedValue.isEditing ?? false
    }
    
    @Binding var inventoryItem: InventoryItem
    
    var body: some View {
        Form {
            nameField("Name")
            countField("Count")
        }
    }
    
    @ViewBuilder
    func nameField(_ label: String) -> some View {
        if isEditing {
            LabeledTextField(label: label, placeholder: "e.g. Valve", value: $inventoryItem.name)
        } else {
            LabeledContent(label) {
                Text(inventoryItem.name)
            }
        }
    }
    
    @ViewBuilder
    func countField(_ label: String) -> some View {
        if isEditing {
            LabeledNumberField(label: label, placeholder: "e.g. 5", value: $inventoryItem.count)
        } else {
            LabeledContent(label) {
                Text(inventoryItem.count)
            }
        }
    }
}

#Preview {
    ContentView()
}
