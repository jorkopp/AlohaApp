//
//  Client+JobChecklistView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 5/26/25.
//

import Foundation
import SwiftUI

extension Client {
    @MainActor
    struct JobChecklistView: View {
        @Environment(\.editMode) private var editMode
        
        @Binding var checklist: JobChecklist
        let inventoryItemNames: [String]
        
        @State private var isAddingNewItem = false
        
        var body: some View {
            NavigationStack {
                if !editMode.isEditing && checklist.items.count == 0 {
                    Text("No items added yet.\nTap the Edit button to get started.")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                List {
                    ForEach(checklist.items.enumerated().sorted(by: { $0.element.name < $1.element.name }), id: \.offset) { pair in
                        HStack {
                            if editMode.isEditing {
                                Button(role: .destructive) {
                                    checklist.items.remove(at: pair.offset)
                                } label: {
                                    Image(systemName: "minus.circle.fill")
                                }
                            }
                            ChecklistRowView(item: $checklist.items[pair.offset])
                        }
                    }
                    if editMode.isEditing {
                        Button {
                            isAddingNewItem = true
                        } label: {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
            }
            .sheet(isPresented: $isAddingNewItem) {
                NavigationStack {
                    NewChecklistItemView(checklist: $checklist, inventoryItemNames: inventoryItemNames)
                }
            }
        }
    }
    
    @MainActor
    struct ChecklistRowView: View {
        @Environment(\.editMode) private var editMode
        
        @Binding var item: ChecklistItem
        
        var body: some View {
            if editMode.isEditing {
                LabeledTextField(label: item.name, placeholder: "0", value: $item.quantity)
            } else {
                LabeledContent(item.name) {
                    Text(item.quantity)
                }
            }
        }
    }
    
    @MainActor
    struct NewChecklistItemView: View {
        @Environment(\.dismiss) private var dismiss
        
        @Binding var checklist: JobChecklist
        let inventoryItemNames: [String]
        @State private var pickerItemNames: [String]
        
        @State private var customItemName: String = ""
        @State private var selectedItemName: String?
        @State private var quantity: String = ""
        @State private var isPresentingCustomItemInput = false
        
        init(checklist: Binding<JobChecklist>, inventoryItemNames: [String]) {
            self._checklist = checklist
            self.inventoryItemNames = inventoryItemNames
            self.pickerItemNames = inventoryItemNames
        }
        
        var body: some View {
            Form {
                // TODO: Custom item and pop up for free form?
                Picker("Item", selection: Binding(
                    get: { selectedItemName },
                    set: { newValue in
                        if newValue == "__custom__" {
                            isPresentingCustomItemInput = true
                        } else {
                            selectedItemName = newValue
                        }
                    }
                )) {
                    Text("Select item").tag(Optional<String>(nil))
                    Text("Custom item").tag(Optional("__custom__"))
                    ForEach(pickerItemNames, id: \.self) { itemName in
                        Text(itemName).tag(itemName)
                    }
                }
                LabeledNumberField(label: "Quantity", placeholder: "0", value: $quantity)
            }
            .alert("Enter Custom Item", isPresented: $isPresentingCustomItemInput, actions: {
                TextField("Name", text: $customItemName)
                Button("Done", action: {
                    pickerItemNames.append(customItemName)
                    selectedItemName = customItemName
                    customItemName = ""
                })
                Button("Cancel", role: .cancel, action: {
                    customItemName = ""
                })
            })
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        checklist.items.append(ChecklistItem(name: selectedItemName ?? "", quantity: quantity))
                        selectedItemName = nil
                        quantity = ""
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        selectedItemName = nil
                        quantity = ""
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    StatefulPreviewWrapper(Client.JobChecklist(items: [])) { binding in
        Client.JobChecklistView(checklist: binding, inventoryItemNames: [])
    }
}

#Preview {
    ContentView()
}
