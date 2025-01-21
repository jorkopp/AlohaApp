//
//  ClientRowView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import SwiftUI

@MainActor
struct ClientRowView: View {
    let clientViewModel: ClientViewModel
    
    var body: some View {
        Text(clientViewModel.name)
    }
}
