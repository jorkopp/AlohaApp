//
//  ClientDetailsView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import SwiftUI

@MainActor
struct ClientDetailsView: View {
    @Environment(\.editMode) private var editMode
    
    @State var clientViewModel: ClientViewModel
    
    private var disableEdits: Bool {
        !(editMode?.wrappedValue.isEditing ?? false)
    }
    
    var body: some View {
        Form {
            Section(header: Text("Contact Info")) {
                TextField("Name", text: $clientViewModel.name)
                    .disabled(disableEdits)
                    .autocorrectionDisabled(true)
                    .autocapitalization(UITextAutocapitalizationType.words)
                if disableEdits {
                    Button {
                        let phoneLink = "tel://" + clientViewModel.phoneNumber.trimmingCharacters(in: .whitespaces)
                        if let url = URL(string: phoneLink) {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        Text(clientViewModel.phoneNumber)
                    }
                } else {
                    TextField("(555) 555-5555", text: $clientViewModel.phoneNumber)
                        .keyboardType(.numberPad)
                        .onChange(of: clientViewModel.phoneNumber, { _, newValue in
                            clientViewModel.phoneNumber = formatPhoneNumber(newValue)
                        })
                }
                emailField()
            }
            Section(header: Text("Property Info")) {
                addressField()
                houseYearField()
                gateCodeField()
                lotSizeField()
                purchaseYearField()
            }
            Section(header: Text("Other")) {
                foundUsField()
                phoneEstimateField()
                notesField()
            }
        }
    }
    
    @ViewBuilder
    func emailField() -> some View {
        TextField("Email", text: $clientViewModel.email)
            .disabled(disableEdits)
            .autocorrectionDisabled(true)
            .keyboardType(.emailAddress)
    }
    
    @ViewBuilder
    func addressField() -> some View {
        TextField("Address", text: $clientViewModel.address)
            .disabled(disableEdits)
    }
    
    //TODO: fix display
    @ViewBuilder
    func houseYearField() -> some View {
        if disableEdits {
            TextField("House Year", value: $clientViewModel.houseYear, format: .number.grouping(.never))
                .disabled(disableEdits)
        } else {
            Picker("House Year", selection: $clientViewModel.houseYear) {
                ForEach(1950...2025, id: \.self) {
                    Text(String($0))
                }
                .pickerStyle(.wheel)
            }
        }
    }
    
    //TODO: fix display
    @ViewBuilder
    func gateCodeField() -> some View {
        TextField("Gate Code", value: $clientViewModel.gateCode, format: .number.grouping(.never))
            .disabled(disableEdits)
            .keyboardType(.numberPad)
    }
    
    //TODO: fix display
    @ViewBuilder
    func lotSizeField() -> some View {
        TextField("Lot Size", value: $clientViewModel.lotSqft, format: .number.grouping(.never))
            .disabled(disableEdits)
            .keyboardType(.numberPad)
            
    }
    
    //TODO: fix display
    @ViewBuilder
    func purchaseYearField() -> some View {
        TextField("Purchase Year", value: $clientViewModel.purchaseYear, format: .number.grouping(.never))
            .disabled(disableEdits)
            .keyboardType(.numberPad)
    }
    
    //fix picker, create enum
    @ViewBuilder
    func foundUsField() -> some View {
        if disableEdits {
            TextField("Found Us", text: $clientViewModel.foundUs)
                .disabled(disableEdits)
        } else {
            Picker("Found Us", selection: $clientViewModel.foundUs) {
                ForEach(1950...2025, id: \.self) {
                    Text(String($0))
                }
                .pickerStyle(.wheel)
            }
        }
    }
    
    //TODO: fix display
    @ViewBuilder
    func phoneEstimateField() -> some View {
        TextField("Phone Estimate", value: $clientViewModel.phoneEstimate, format: .number.grouping(.never))
            .disabled(disableEdits)
            .keyboardType(.numberPad)
    }
    
    //TODO: convert to texteditor
    @ViewBuilder
    func notesField() -> some View {
        TextField("Notes", text: $clientViewModel.notes)
            .disabled(disableEdits)
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
