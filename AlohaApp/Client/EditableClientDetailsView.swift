//
//  EditableClientDetailsView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import SwiftUI

struct EditableClientDetailsView: View {
    @State var name: String
    
    var body: some View {
        ClientDetailsView(name: name)
            .toolbar {
                EditButton()
            }
    }
}

#Preview {
    ContentView()
}
