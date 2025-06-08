//
//  ItemListView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 5/25/25.
//

import Foundation

import SwiftUI

@MainActor
struct ItemListView<T: Item, RowContent: View, DetailsContent: View>: View {
    let title: String
    let itemListManager: ItemListManager<T>
    
    let rowContent: (T) -> RowContent
    let detailsContent: (T) -> DetailsContent
    
    @State private var isAddingNewItem = false
    @State private var isShowingDeleteAlert: Bool = false
    @State private var indexSetToDelete: IndexSet?
    
    var body: some View {
        Group {
            List {
                ForEach(itemListManager.items, id: \.self) { item in
                    NavigationLink {
                        EditableItemView(itemListManager: itemListManager, item: item) { item in
                            detailsContent(item)
                        }
                    } label: {
                        rowContent(item)
                    }
                }
                .onDelete { indexSet in
                    isShowingDeleteAlert = true
                    indexSetToDelete = indexSet
                }
            }
        }
        .navigationTitle(title)
        .toolbar {
            if !itemListManager.items.isEmpty {
                ToolbarItem {
                    EditButton()
                }
            }
            ToolbarItem {
                Button {
                    isAddingNewItem = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }

        .sheet(isPresented: $isAddingNewItem) {
            NavigationStack {
                NewItemView(itemListManager: itemListManager) { item in
                    detailsContent(item)
                }
            }
        }
        .alert("Are you sure you want to delete this \(T.name)?", isPresented: $isShowingDeleteAlert) {
            Button("Delete", role: .destructive) {
                if let indexSet = indexSetToDelete {
                    for index in indexSet {
                        let itemToDelete = itemListManager.items[index]
                        itemListManager.delete(itemToDelete)
                    }
                }
            }
            Button("Cancel", role: .cancel) {
                indexSetToDelete = nil
            }
        }
    }
}

#Preview {
    ContentView()
}
