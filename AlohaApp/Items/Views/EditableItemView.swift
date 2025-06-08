//
//  EditableItemView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 5/25/25.
//

import SwiftUI

@MainActor
struct EditableItemView<T: Item, DetailsContent: View>: View {
    @Environment(\.editMode) private var editMode
    @State private var localEditMode: EditMode = .inactive
    
    let itemListManager: ItemListManager<T>
    let item: T
    let detailsContent: (T) -> DetailsContent
    
    var body: some View {
        detailsContent(item)
            .navigationBarItems(trailing: EditButton())
            .environment(\.editMode, $localEditMode)
            .onChange(of: localEditMode) { oldValue, newValue in
                if oldValue != newValue {
                    if newValue == .inactive {
                        if item.isValid() {
                            itemListManager.save(item)
                        } else {
                            localEditMode = .active
                        }
                    }
                }
            }
    }
}

#Preview {
    ContentView()
}

