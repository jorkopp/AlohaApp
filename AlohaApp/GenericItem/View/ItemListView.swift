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
    let detailsContent: (Binding<T>) -> DetailsContent
    
    @State private var isAddingNewItem = false
    
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
                    for index in indexSet {
                        let itemToDelete = itemListManager.items[index]
                        itemListManager.delete(itemToDelete)
                    }
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
        .navigationDestination(isPresented: $isAddingNewItem) {
            NewItemView(itemListManager: itemListManager) { item in
                detailsContent(item)
            }
        }
    }
}

#Preview {
    ContentView()
}
