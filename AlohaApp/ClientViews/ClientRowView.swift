//
//  ClientRowView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import SwiftUI

@MainActor
struct ClientRowView: View {
    let client: Client
    
    var body: some View {
        Text(client.name)
    }
}
