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
                nameField()
            }
            countField("Count")
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
    func nameField() -> some View {
        if isEditing {
            LabeledContent("Name") {
                TextField("Name", text: $localInventoryItem.name)
                    .multilineTextAlignment(.trailing)
                    .autocorrectionDisabled(true)
                    .autocapitalization(UITextAutocapitalizationType.words)
            }
        } else {
            LabeledContent("Name") {
                Text(inventoryItem.name)
            }
        }
    }
    
    @ViewBuilder
    func countField(_ label: String) -> some View {
        if isEditing {
//            LabeledNumberField(label: label, placeholder: "", value: <#T##Binding<String>#>)
            Stepper("Count: \(localInventoryItem.count)", value: $localInventoryItem.count, in: 0...100)
        } else {
            LabeledContent("Count") {
                Text(String(inventoryItem.count))
            }
        }
    }
}
