//
//  Client+RowView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import Foundation
import SwiftUI

extension Client {
    @MainActor
    struct RowView: View {
        let clientModel: Model
        
        var body: some View {
            Text(clientModel.contactInfo.name)
        }
    }
}

#Preview {
    Client.RowView(clientModel: Client.Model(contactInfo: Client.ContactInfo(name: "Test Client")))
}
