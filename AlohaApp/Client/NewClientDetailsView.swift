//
//  NewClientDetailsView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import SwiftUI

struct NewClientDetailsView: View {
    @Environment(\.editMode) private var editMode
    @Environment(\.dismiss) private var dismiss
    
    @State var name: String
    
    var body: some View {
        ClientDetailsView(name: name)
            .environment(\.editMode, Binding.constant(EditMode.active))
            .navigationTitle("New Client")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        // TODO: Persist
                        dismiss()
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
