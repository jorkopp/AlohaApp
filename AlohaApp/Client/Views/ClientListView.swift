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
    
    @State var clientListViewModel: ClientListViewModel
    
    var body: some View {
        Group {
            List {
                ForEach(clientListViewModel.sortedClients, id: \.self) { clientViewModel in
                    NavigationLink {
                        EditableClientDetailsView(clientViewModel: clientViewModel)
                    } label: {
                        ClientRowView(clientViewModel: clientViewModel)
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        let clientViewModelToDelete = clientListViewModel.sortedClients[index]
                        clientViewModelToDelete.delete()
                        clientListViewModel.clientViewModelsByClientID.removeValue(forKey: clientViewModelToDelete.id)
                    }
                }
            }
        }
        .navigationTitle("Clients")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                EditButton()
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
            clientListViewModel.startFetchingClientData()
        }
        .sheet(isPresented: $isAddingNewClient) {
            NavigationStack {
                NewClientDetailsView(clientViewModel: ClientViewModel.newClientViewModel())
            }
        }
    }
}

#Preview {
    ContentView()
}
