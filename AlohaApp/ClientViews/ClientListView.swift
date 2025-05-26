//
//  ClientListView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import SwiftUI

@MainActor
struct ClientListView: View {
    @State var isAddingNewClient = false
    
    let clientItemListManager: ItemListManager<Client>
    
    var body: some View {
        Group {
            List {
                ForEach(clientItemListManager.items, id: \.self) { client in
                    NavigationLink {
                        EditableClientView(clientItemListManager: clientItemListManager, client: client)
                    } label: {
                        ClientRowView(client: client)
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        let clientToDelete = clientItemListManager.items[index]
                        clientItemListManager.delete(clientToDelete)
                    }
                }
            }
        }
        .navigationTitle("Clients")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if !clientItemListManager.items.isEmpty {
                ToolbarItem {
                    EditButton()
                }
            }
            ToolbarItem {
                Button {
                    isAddingNewClient = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .onAppear {
            clientItemListManager.startFetchingItems()
        }
        .sheet(isPresented: $isAddingNewClient) {
            NavigationStack {
                NewClientView(clientItemListManager: clientItemListManager)
            }
        }
    }
}

#Preview {
    ContentView()
}
