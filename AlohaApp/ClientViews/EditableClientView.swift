//
//  EditableClientView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import SwiftUI

@MainActor
struct EditableClientView: View {
    @Environment(\.editMode) private var editMode
    @State private var localEditMode: EditMode = .inactive
    
    let clientItemListManager: ItemListManager<Client>
    
    let client: Client
    @State private var showMissingFieldsAlert = false
    
    var body: some View {
        ClientDetailsView(client: client)
            .navigationBarItems(trailing: EditButton())
            .environment(\.editMode, $localEditMode)
            .onChange(of: localEditMode) { oldValue, newValue in
                if oldValue != newValue {
                    if newValue == .inactive {
                        if client.isValid() {
                            clientItemListManager.save(client)
                        } else {
                            localEditMode = .active
                            showMissingFieldsAlert = true
                        }
                    }
                }
            }
            .missingFieldsAlert(isPresented: $showMissingFieldsAlert)
    }
}

#Preview {
    ContentView()
}
