//
//  EstimateListView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import SwiftUI
import FirebaseDatabaseInternal

@MainActor
struct EstimateListView: View {
    @State var isAddingNewEstimate = false
    
    let estimateItemListManager: ItemListManager<Estimate>
    
    var body: some View {
        Group {
            List {
                ForEach(estimateItemListManager.items, id: \.self) { estimate in
                    NavigationLink {
                        EditableEstimateView(estimateItemListManager: estimateItemListManager, estimate: estimate)
                    } label: {
                        EstimateRowView(Estimate: estimate)
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        let estimateToDelete = estimateItemListManager.items[index]
                        estimateItemListManager.delete(estimateToDelete)
                    }
                }
            }
        }
        .navigationTitle("Estimates")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if !estimateItemListManager.items.isEmpty {
                ToolbarItem {
                    EditButton()
                }
            }
            ToolbarItem {
                Button {
                    isAddingNewEstimate = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .onAppear {
            estimateItemListManager.startFetchingItems()
        }
        .sheet(isPresented: $isAddingNewEstimate) {
            NavigationStack {
                NewEstimateView(estimateItemListManager: estimateItemListManager)
            }
        }
    }
}

#Preview {
    ContentView()
}
