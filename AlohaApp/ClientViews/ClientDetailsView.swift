//
//  ClientDetailsView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import SwiftUI

@MainActor
struct ClientDetailsView: View {
    @Environment(\.editMode) private var editMode
    
    private var isEditing: Bool {
        editMode?.wrappedValue.isEditing ?? false
    }
    
    @Bindable var client: Client
    @State private var localClient: Client
    @State private var selectedTab = 0
    
    public init(client: Client) {
        self.client = client
        _localClient = State(initialValue: client)
    }
    
    var body: some View {
        NavigationStack {
            Picker("Client Detail Section", selection: $selectedTab) {
                Text("Contact Info").tag(0)
                Text("Site Assessment").tag(1)
                Text("Job Checklist").tag(2)
            }
            .pickerStyle(.segmented)
            .padding()
            switch selectedTab {
            case 0:
                ContactInfoView(client: client)
            case 1, 2:
                VStack {
                    Text("TODO")
                    Spacer()
                }
            default:
                EmptyView()
            }
        }
        .navigationTitle(client.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ContentView()
}
