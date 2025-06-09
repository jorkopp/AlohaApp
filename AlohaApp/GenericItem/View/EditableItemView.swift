//
//  EditableItemView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 5/25/25.
//

import Foundation
import SwiftUI

@MainActor
struct EditableItemView<T: Item, DetailsContent: View>: View {
    @Environment(\.editMode) private var editMode
    @State private var localEditMode: EditMode
    @State private var editableItem: T
    
    let itemListManager: ItemListManager<T>
    let detailsContent: (Binding<T>) -> DetailsContent
    
    init(itemListManager: ItemListManager<T>, item: T, initialEditMode: EditMode = .inactive, detailsContent: @escaping (Binding<T>) -> DetailsContent) {
        self.itemListManager = itemListManager
        self._editableItem = State(initialValue: item)
        self.detailsContent = detailsContent
        self._localEditMode = .init(initialValue: initialEditMode)
    }
    
    var body: some View {
        detailsContent($editableItem)
            .navigationBarItems(trailing: EditButton())
            .environment(\.editMode, $localEditMode)
            .onChange(of: localEditMode) { oldValue, newValue in
                if oldValue != newValue {
                    if newValue == .inactive {
                        if editableItem.id != nil {
                            itemListManager.update(editableItem)
                        } else {
                            itemListManager.save(editableItem)
                        }
                    }
                }
            }
    }
}

extension Optional where Wrapped == Binding<EditMode> {
    var isEditing: Bool {
        self?.wrappedValue.isEditing ?? false
    }
}
