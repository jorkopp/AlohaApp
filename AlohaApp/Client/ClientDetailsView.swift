//
//  ClientDetailsView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import SwiftUI

struct ClientDetailsView: View {
    @Environment(\.editMode) private var editMode
    
    @State var name: String
    
    var body: some View {
        Form {
            LabeledContent("Name") {
                TextField("Jane Doe", text: $name)
                    .disabled(!(editMode?.wrappedValue.isEditing ?? false))
            }
        }
        .multilineTextAlignment(.trailing)
    }
}

#Preview {
    ContentView()
}
