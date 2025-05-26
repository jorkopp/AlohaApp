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
    @State var isAddingNewItem = false
    
    let title: String
    let itemListManager: ItemListManager<T>
    
    let rowContent: (T) -> RowContent
    let detailsContent: (T) -> DetailsContent
    
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
        .navigationBarTitleDisplayMode(.inline)
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
        .onAppear {
            itemListManager.startFetchingItems()
        }
        .sheet(isPresented: $isAddingNewItem) {
            NavigationStack {
                NewItemView(itemListManager: itemListManager) { item in
                    detailsContent(item)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
