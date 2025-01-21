//
//  EditableClientDetailsView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import SwiftUI

@MainActor
struct EditableClientDetailsView: View {
    @Environment(\.editMode) private var editMode
    @State private var isEditing = false
    
    var clientViewModel: ClientViewModel
    
    var body: some View {
        ClientDetailsView(clientViewModel: clientViewModel)
            .toolbar {
                EditButton()
            }
            .onChange(of: editMode?.wrappedValue) { _, newValue in
                if newValue == .inactive && isEditing { // Done Button pressed!
                    clientViewModel.saveChanges()
                }
                isEditing = (newValue == .active)
            }
        // TODO: How to not let Done do anything when !clientViewModel.isValid
    }
}

#Preview {
    ContentView()
}
