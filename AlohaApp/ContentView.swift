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
                ItemListView(title: "Clients", itemListManager: clientItemListManager) { item in
                    Client.RowView(clientModel: item)
                } detailsContent: { item in
                    Client.DetailsView(clientModel: item, inventoryItemNames: inventoryItemListManager.items.map { $0.name })
                }
            }
            .tabItem {
                Label("Clients", systemImage: "person")
            }
            NavigationStack {
                ItemListView(title: "Inventory", itemListManager: inventoryItemListManager) { item in
                    InventoryItem.RowView(inventoryItemModel: item)
                } detailsContent: { item in
                    InventoryItem.DetailsView(inventoryItemModel: item)
                }
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
