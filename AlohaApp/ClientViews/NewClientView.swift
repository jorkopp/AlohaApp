//
//  NewClientView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import SwiftUI

@MainActor
struct NewClientView: View {
    @Environment(\.editMode) private var editMode
    @Environment(\.dismiss) private var dismiss
    
    let clientItemListManager: ItemListManager<Client>
    
    private let client = Client.newItem()
    @State private var showMissingFieldsAlert = false
    
    var body: some View {
        ClientDetailsView(client: client)
            .environment(\.editMode, Binding.constant(EditMode.active))
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        if client.isValid() {
                            clientItemListManager.save(client)
                            dismiss()
                        } else {
                            showMissingFieldsAlert = true
                        }
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .missingFieldsAlert(isPresented: $showMissingFieldsAlert)
    }
}

#Preview {
    ContentView()
}
