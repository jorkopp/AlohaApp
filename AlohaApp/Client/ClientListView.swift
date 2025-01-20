//
//  ClientListView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import SwiftUI

struct ClientListView: View {
    @State var isAddingNewClient = false
    
    let names: [String]
    
    var body: some View {
        Group {
            List(names, id: \.self) { name in
                NavigationLink {
                    EditableClientDetailsView(name: name)
                } label: {
                    ClientRowView(name: name)
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        isAddingNewClient = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .navigationTitle("Clients")
        .sheet(isPresented: $isAddingNewClient) {
            NavigationStack {
                NewClientDetailsView(name: "")
            }
        }
    }
    
    private func addClient() {
        
    }
}

#Preview {
    ContentView()
}
