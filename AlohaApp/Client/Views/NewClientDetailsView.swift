//
//  NewClientDetailsView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import SwiftUI

@MainActor
struct NewClientDetailsView: View {
    @Environment(\.editMode) private var editMode
    @Environment(\.dismiss) private var dismiss
    
    var clientViewModel: ClientViewModel
    
    var body: some View {
        ClientDetailsView(clientViewModel: clientViewModel)
            .environment(\.editMode, Binding.constant(EditMode.active))
            .navigationTitle("New Client")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        if clientViewModel.isValid {
                            clientViewModel.saveChanges()
                            dismiss()
                        }
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
    }
}

#Preview {
    ContentView()
}
