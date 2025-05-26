//
//  EditableEstimateView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import SwiftUI
import FirebaseDatabaseInternal

@MainActor
struct EditableEstimateView: View {
    @Environment(\.editMode) private var editMode
    @State private var isEditing = false
    
    let estimateItemListManager: ItemListManager<Estimate>
    
    let estimate: Estimate
    @State private var showMissingFieldsAlert = false
    
    var body: some View {
        EstimateView(estimate: estimate)
            .toolbar {
                if !isEditing {
                    Button("Edit") {
                        isEditing = true
                    }
                } else {
                    Button("Done") {
                        if estimate.isValid() {
                            estimateItemListManager.save(estimate)
                            isEditing = false
                        } else {
                            showMissingFieldsAlert = true
                        }
                    }
                }
            }
            .missingFieldsAlert(isPresented: $showMissingFieldsAlert)
    }
}

#Preview {
    ContentView()
}
