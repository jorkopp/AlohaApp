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
    let sectionForItem: ((T) -> String)?
    
    @State private var isAddingNewItem = false
    
    var body: some View {
        Group {
            let itemsBySection: [String: [T]]? = if let sectionForItem { Dictionary(grouping: itemListManager.items, by: sectionForItem) } else { nil }
            List {
                if let itemsBySection {
                    ForEach(itemsBySection.keys.sorted(), id: \.self) { section in
                        Section(header: Text(section)) {
                            let sectionItems = itemsBySection[section, default: []]
                            ForEach(sectionItems, id: \.self) { item in
                                listItem(item)
                            }
                            .onDelete { indexSet in
                                for index in indexSet {
                                    let itemToDelete = sectionItems[index]
                                    itemListManager.delete(itemToDelete)
                                }
                            }
                        }
                    }
                } else {
                    ForEach(itemListManager.items, id: \.self) { item in
                        listItem(item)
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            let itemToDelete = itemListManager.items[index]
                            itemListManager.delete(itemToDelete)
                        }
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
    
    @ViewBuilder
    func listItem(_ item: T) -> some View {
        NavigationLink {
            EditableItemView(itemListManager: itemListManager, item: item) { item in
                detailsContent(item)
            }
        } label: {
            rowContent(item)
        }
    }
}

#Preview {
    ContentView()
}
