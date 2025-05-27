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
    
    @Bindable var inventoryItem: InventoryItem
    @State private var localInventoryItem: InventoryItem
    
    public init(inventoryItem: InventoryItem) {
        self.inventoryItem = inventoryItem
        _localInventoryItem = State(initialValue: inventoryItem)
    }
    
    var body: some View {
        Form {
            RequiredField(isEditing: isEditing) {
                nameField("Name")
            }
            RequiredField(isEditing: isEditing) {
                countField("Count")
            }
        }
        .onChange(of: isEditing) { oldValue, newValue in
            guard oldValue != newValue else { return }
            if !newValue && oldValue {
                inventoryItem.update(from: localInventoryItem)
            }
        }
        .onChange(of: inventoryItem) { _, newValue in
            if !isEditing {
                localInventoryItem = inventoryItem
            }
        }
    }
    
    @ViewBuilder
    func nameField(_ label: String) -> some View {
        if isEditing {
            LabeledTextField(label: label, placeholder: "e.g. Valve", value: $localInventoryItem.name)
        } else {
            LabeledContent(label) {
                Text(inventoryItem.name)
            }
        }
    }
    
    @ViewBuilder
    func countField(_ label: String) -> some View {
        if isEditing {
            LabeledNumberField(label: label, placeholder: "e.g. 5", value: $localInventoryItem.count)
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
