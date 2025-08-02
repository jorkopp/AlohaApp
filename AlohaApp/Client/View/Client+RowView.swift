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
            HStack {
                Text(clientModel.contactInfo.name)
                Spacer()
                if (clientModel.contactInfo.signOnSite) {
                    Image(systemName: "house.and.flag")
                }
            }
        }
    }
}

#Preview {
    Client.RowView(clientModel: Client.Model(contactInfo: Client.ContactInfo(name: "Test Client")))
}
