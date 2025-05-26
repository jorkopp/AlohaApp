//
//  NewItemView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 5/25/25.
//

import SwiftUI

@MainActor
struct NewItemView<T: Item, DetailsContent: View>: View {
    @Environment(\.editMode) private var editMode
    @Environment(\.dismiss) private var dismiss
    
    let itemListManager: ItemListManager<T>
    let detailsContent: (T) -> DetailsContent
    
    private let item = T.newItem()
    @State private var showMissingFieldsAlert = false
    
    var body: some View {
        detailsContent(item)
            .environment(\.editMode, Binding.constant(EditMode.active))
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        if item.isValid() {
                            itemListManager.save(item)
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

public extension View {
    func missingFieldsAlert(isPresented: Binding<Bool>) -> some View {
        self.alert("Missing Required Fields", isPresented: isPresented) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please complete all required fields before proceeding.")
        }
    }
}

#Preview {
    ContentView()
}
