//
//  ContentView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import SwiftUI
import Firebase

struct ContentView: View {
    private let clientItemListManager = ItemListManager<Client>()
    private let inventoryItemListManager = ItemListManager<InventoryItem>()
    
    var body: some View {
        TabView {
            NavigationStack {
                ItemListView(title: "Clients", itemListManager: clientItemListManager) { item in
                    ClientRowView(client: item)
                } detailsContent: { item in
                    ClientDetailsView(client: item)
                }
            }
            .tabItem {
                Label("Clients", systemImage: "person")
            }
            NavigationStack {
                ItemListView(title: "Inventory", itemListManager: inventoryItemListManager) { item in
                    InventoryItemRowView(inventoryItem: item)
                } detailsContent: { item in
                    InventoryItemDetailsView(inventoryItem: item)
                }
            }
            .tabItem {
                Label("Inventory", systemImage: "truck.box")
            }
        }
    }
}

#Preview {
    ContentView()
}
