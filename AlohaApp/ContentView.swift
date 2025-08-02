//
//  ContentView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import Foundation
import SwiftUI
import Firebase

struct ContentView: View {
    private let clientItemListManager = ItemListManager<Client.Model>()
    private let inventoryItemListManager = ItemListManager<InventoryItem.Model>()
    
    var body: some View {
        TabView {
            NavigationStack {
                ItemListView(
                    title: "Clients",
                    itemListManager: clientItemListManager,
                    rowContent: { Client.RowView(clientModel: $0) },
                    detailsContent: { Client.DetailsView(clientModel: $0, inventoryItemNames: inventoryItemListManager.items.map { $0.name }) },
                    sectionForItem: { $0.contactInfo.active ? "Active" : "Inactive" }
                )
            }
            .tabItem {
                Label("Clients", systemImage: "person")
            }
            NavigationStack {
                ItemListView(
                    title: "Inventory",
                    itemListManager: inventoryItemListManager,
                    rowContent: { InventoryItem.RowView(inventoryItemModel: $0) },
                    detailsContent: { InventoryItem.DetailsView(inventoryItemModel: $0) },
                    sectionForItem: { if $0.category.count == 0 { "Uncategorized" } else { $0.category } }
                )
            }
            .tabItem {
                Label("Inventory", systemImage: "truck.box")
            }
        }
        .onAppear {
            clientItemListManager.startFetchingItems()
            inventoryItemListManager.startFetchingItems()
        }
    }
}

#Preview {
    ContentView()
}
