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
        Group {
            EditableItemView(itemListManager: itemListManager, item: newItem, initialEditMode: .active) { item in
                detailsContent(item)
            }
        }
    }
}

#Preview {
    ContentView()
}
