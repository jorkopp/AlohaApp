//
//  ContentView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import SwiftUI
import Firebase

struct ContentView: View {
//    private let clientsViewModel = ClientsViewModel()
    private let clientItemListManager = ItemListManager<Client>()
    private let estimateItemListManager = ItemListManager<Estimate>()
    private let inventoryItemListManager = ItemListManager<InventoryItem>()
    
    //TODO: fix add button not visible from tab view
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
                ItemListView(title: "Estimates", itemListManager: estimateItemListManager) { item in
                    EstimateRowView(estimate: item)
                } detailsContent: { item in
                    EstimateDetailsView(estimate: item)
                }            }
            .tabItem {
                Label("Estimates", systemImage: "dollarsign.square.fill")
            }
            NavigationStack {
                ItemListView(title: "Inventory", itemListManager: inventoryItemListManager) { item in
                    InventoryItemRowView(inventoryItem: item)
                } detailsContent: { item in
                    InventoryItemDetailsView(inventoryItem: item)
                }            }
            .tabItem {
                Label("Inventory", systemImage: "truck.box")
            }
        }
    }
}

#Preview {
    ContentView()
}
