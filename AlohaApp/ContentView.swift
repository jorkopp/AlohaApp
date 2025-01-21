//
//  ContentView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import SwiftUI
import Firebase

struct ContentView: View {
    private let clientListViewModel = ClientListViewModel()
    
    var body: some View {
        NavigationStack {
            ClientListView(clientListViewModel: clientListViewModel)
        }
    }
}

#Preview {
    ContentView()
}
