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
    
    var body: some View {
        detailsContent(item)
            .environment(\.editMode, Binding.constant(EditMode.active))
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        itemListManager.save(item)
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
