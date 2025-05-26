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
        }
    }
}

#Preview {
    ContentView()
}
