////
////  ChecklistListView.swift
////  AlohaApp
////
////  Created by Jordan Kopp on 5/26/25.
////
//
//import SwiftUI
//
//@MainActor
//struct ChecklistRowView: View {
//    let checklist: Checklist
//    
//    var body: some View {
//        Text(checklist.name)
//    }
//}
//
//@MainActor
//struct ChecklistDetailsView: View {
//    @Environment(\.editMode) private var editMode
//    
//    private var isEditing: Bool {
//        editMode?.wrappedValue.isEditing ?? false
//    }
//    
//    @Bindable var checklist: Checklist
//    let checklistItemListManager: ItemListManager<Checklist>
//    let inventoryItemListManager: ItemListManager<InventoryItem>
//    
//    @State private var isEditingChecklistName = false
//    @State private var isShowingNewChecklistItem = false
//    @State private var isShowingDeleteAlert: Bool = false
//    @State private var indexSetToDelete: IndexSet?
//    
//    @State private var selectedInventoryItem: InventoryItem?
//    @State private var quantity: String = ""
//    
//    var body: some View {
//        NavigationStack {
//            List {
//                ForEach(sortedItemUUIDs, id: \.self) { itemUUID in
//                    rowView(itemUUID, quantity: checklist.quantityByItemUUID[itemUUID]!)
//                }
//                .onDelete { indexSet in
//                    for index in indexSet {
//                        let itemUUIDToDelete = sortedItemUUIDs[index]
//                        var newQuantityByItemUUID = checklist.quantityByItemUUID
//                        newQuantityByItemUUID.removeValue(forKey: itemUUIDToDelete)
//                        checklist.quantityByItemUUID = newQuantityByItemUUID
//                        checklistItemListManager.save(checklist)
//                    }
//                }
//                if isEditing {
//                    Button {
//                        isShowingNewChecklistItem = true
//                    } label: {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        }
//        .toolbar {
//            ToolbarItem(placement: .principal) {
//                if isEditing {
//                    TextField("", text: $checklist.name)
//                        .font(.headline)
//                        .foregroundColor(.primary)
//                        .multilineTextAlignment(.center)
//                        .textFieldStyle(PlainTextFieldStyle())
//                } else {
//                    Text(checklist.name)
//                        .font(.headline)
//                }
//            }
//        }
//        .sheet(isPresented: $isShowingNewChecklistItem) {
//            NavigationStack {
//                NewChecklistItemView(checklist: checklist, checklistItemListManager: checklistItemListManager, inventoryItemListManager: inventoryItemListManager)
//            }
//        }
//    }
//    
//    private var sortedItemUUIDs: [String] {
//        Array(checklist.quantityByItemUUID.keys).sorted { lhs, rhs in
//            if let lhsItem = inventoryItemListManager.itemsByUUID[lhs], let rhsItem = inventoryItemListManager.itemsByUUID[rhs] {
//                return lhsItem.name < rhsItem.name
//            } else {
//                return true
//            }
//        }
//    }
//    
//    @ViewBuilder
//    func rowView(_ itemUUID: String, quantity: String) -> some View {
//        if let item = inventoryItemListManager.itemsByUUID[itemUUID] {
//            ChecklistItemRowView(item: item, quantity: quantity)
//        } else {
//            EmptyView()
//        }
//    }
//}
//
//@MainActor
//struct ChecklistItemRowView: View {
//    let item: InventoryItem
//    let quantity: String
//    
//    var body: some View {
//        HStack {
//            Text(item.name)
//            Text("(\(quantity))")
//        }
//    }
//}
//
//// TODO: Unable to edit quantity after new checklist item added
//
//@MainActor
//struct NewChecklistItemView: View {
//    @Bindable var checklist: Checklist
//    
//    let checklistItemListManager: ItemListManager<Checklist>
//    let inventoryItemListManager: ItemListManager<InventoryItem>
//    
//    @Environment(\.dismiss) private var dismiss
//    @State private var selectedInventoryItem: InventoryItem?
//    @State private var quantity: String = ""
//    @State private var isShowingMissingFieldsAlert = false
//    
//    var body: some View {
//        Form {
//            Picker("Item", selection: $selectedInventoryItem) {
//                Text("Select item").tag(Optional<InventoryItem>(nil))
//                ForEach(inventoryItemListManager.items, id: \.self) { item in
//                    Text(item.name).tag(item)
//                }
//            }
//            LabeledNumberField(label: "Quantity", placeholder: "e.g. 5", value: $quantity)
//        }
//        .toolbar {
//            ToolbarItem(placement: .confirmationAction) {
//                Button("Done") {
//                    if let currentSelectedInventoryItem = selectedInventoryItem {
//                        var newQuantityByItemUUID = checklist.quantityByItemUUID
//                        newQuantityByItemUUID[currentSelectedInventoryItem.uuid] = quantity
//                        checklist.quantityByItemUUID = newQuantityByItemUUID
//                        checklistItemListManager.save(checklist)
//                        selectedInventoryItem = nil
//                        quantity = ""
//                        dismiss()
//                    }
//                }
//            }
//            ToolbarItem(placement: .cancellationAction) {
//                Button("Cancel") {
//                    selectedInventoryItem = nil
//                    quantity = ""
//                    dismiss()
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}
