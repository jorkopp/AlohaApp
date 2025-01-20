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
    @State var phoneNumber: String = ""
    
    private var disableEdits: Bool {
        !(editMode?.wrappedValue.isEditing ?? false)
    }
    
    var body: some View {
        Form {
            Section(header: Text("Contact Info")) {
                TextField("Name", text: $name)
                    .disabled(disableEdits)
                
                if disableEdits {
                    Button {
                        let phoneLink = "tel://" + phoneNumber.trimmingCharacters(in: .whitespaces)
                        if let url = URL(string: phoneLink) {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        Text(phoneNumber)
                    }
                } else {
                    TextField("(555) 555-5555", text: $phoneNumber)
                        .keyboardType(.numberPad)
                        .onChange(of: phoneNumber, { _, newValue in
                            phoneNumber = formatPhoneNumber(newValue)
                        })
                }
            }
        }
    }
    
    // Helper function to format the phone number
    func formatPhoneNumber(_ phoneNumber: String) -> String {
        // Remove any non-numeric characters + limit to 10
        let cleanedPhoneNumber = String(phoneNumber.filter { $0.isNumber }.prefix(10))
        
        // Apply formatting
        let numberOfDigits = cleanedPhoneNumber.count
        switch numberOfDigits {
        case 0...3:
            return cleanedPhoneNumber
        case 4...6:
            return "(\(cleanedPhoneNumber.prefix(3))) \(cleanedPhoneNumber.suffix(numberOfDigits - 3))"
        default:
            let middleNumber = cleanedPhoneNumber[cleanedPhoneNumber.index(cleanedPhoneNumber.startIndex, offsetBy: 3)..<cleanedPhoneNumber.index(cleanedPhoneNumber.startIndex, offsetBy: 6)]
            return "(\(cleanedPhoneNumber.prefix(3))) \(middleNumber)-\(cleanedPhoneNumber.suffix((numberOfDigits - 6)))"
        }
    }
}

#Preview {
    ContentView()
}
