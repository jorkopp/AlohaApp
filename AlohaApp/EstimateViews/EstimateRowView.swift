//
//  EstimateRowView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import SwiftUI

@MainActor
struct EstimateRowView: View {
    let estimate: Estimate
    
    var body: some View {
        Text(estimate.uuid)
    }
}

#Preview {
    ContentView()
}
