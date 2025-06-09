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
    @State private var localEditMode: EditMode = .inactive
    @State private var editableItem: T
    
    let itemListManager: ItemListManager<T>
    let detailsContent: (Binding<T>) -> DetailsContent
    
    init(itemListManager: ItemListManager<T>, item: T, detailsContent: @escaping (Binding<T>) -> DetailsContent) {
        self.itemListManager = itemListManager
        self._editableItem = State(initialValue: item)
        self.detailsContent = detailsContent
    }
    
    var body: some View {
        detailsContent($editableItem)
            .navigationBarItems(trailing: EditButton())
            .environment(\.editMode, $localEditMode)
            .onChange(of: localEditMode) { oldValue, newValue in
                if oldValue != newValue {
                    if newValue == .inactive {
                        itemListManager.update(editableItem)
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
