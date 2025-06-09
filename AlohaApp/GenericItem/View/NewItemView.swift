//
//  NewItemView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 5/25/25.
//

import Foundation
import SwiftUI

@MainActor
struct NewItemView<T: Item, DetailsContent: View>: View {
    @Environment(\.editMode) private var editMode
    @Environment(\.dismiss) private var dismiss
    @State private var newItem = T.newItem()
    
    let itemListManager: ItemListManager<T>
    let detailsContent: (Binding<T>) -> DetailsContent
    
    var body: some View {
        detailsContent($newItem)
            .environment(\.editMode, Binding.constant(EditMode.active))
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        itemListManager.save(newItem)
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
