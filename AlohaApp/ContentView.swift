//
//  ContentView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import SwiftUI
import Firebase

/*
 database = JSON
 {
    "clients" : [
        {
            "name" : "Sam"
        },
        {
            "name" : "Jordan"
        }
    ]
 }
 */

struct ContentView: View {
    private let ref: DatabaseReference! = Database.database().reference()
    @State private var refHandle: DatabaseHandle?
    
    @State private var clientNames: [String] = []

    var body: some View {
        NavigationStack {
            ClientListView(names: clientNames)
        }
        .onAppear {
            self.refHandle = ref.observe(DataEventType.value, with: { snapshot in
                let value = (snapshot.value as? [String: Any]) ?? [:]
                let clientsData = (value["clients"] as? [[String: Any]]) ?? []
                self.clientNames = clientsData.compactMap { $0["name"] as? String }
            })
        }
    }
    
    static func writeDummyData() {
        // write jordan/sam
    }
}

#Preview {
    ContentView()
}
