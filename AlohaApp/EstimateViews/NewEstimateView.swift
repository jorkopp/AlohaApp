//
//  NewEstimateView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import SwiftUI
import FirebaseDatabaseInternal

@MainActor
struct NewEstimateView: View {
    @Environment(\.editMode) private var editMode
    @Environment(\.dismiss) private var dismiss
    
    let estimateItemListManager: ItemListManager<Estimate>
    
    private let estimate = Estimate.newItem()
    
    var body: some View {
        EstimateView(estimate: estimate)
            .environment(\.editMode, Binding.constant(EditMode.active))
            .navigationTitle("New Estimate")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        if estimate.isValid() {
                            estimateItemListManager.save(estimate)
                            dismiss()
                        } else {
                            
                        }
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
