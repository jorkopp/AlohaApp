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
    
    private var isEditing: Bool {
        editMode?.wrappedValue.isEditing ?? false
    }
    
    @Bindable var client: Client
    @State private var localClient: Client
    
    public init(client: Client) {
        self.client = client
        _localClient = State(initialValue: client)
    }
    
    var body: some View {
        Form {
            Section(header: Text("Contact Info")) {
                RequiredField(isEditing: isEditing) {
                    nameField("Name")
                }
                RequiredField(isEditing: isEditing) {
                    phoneNumberField("Phone")
                }
                RequiredField(isEditing: isEditing) {
                    emailField("Email")
                }
                foundUsField("Found Us")
            }
            Section(header: Text("Property Info")) {
                RequiredField(isEditing: isEditing) {
                    addressField("Address")
                }
                houseYearField("House Year Built")
                purchaseYearField("Purchase Year")
                lotSizeField("Lot Size (sq ft)")
                gateCodeField("Gate Code")
                phoneEstimateField("Phone Estimate")
            }
            Section(header: Text("Notes")) {
                notesField()
            }
        }
        .onChange(of: isEditing) { oldValue, newValue in
            guard oldValue != newValue else { return }
            if !newValue && oldValue {
                client.update(from: localClient)
            }
        }
        .onChange(of: client) { _, newValue in
            if !isEditing {
                localClient = newValue
            }
        }
    }
    
    @ViewBuilder
    func nameField(_ label: String) -> some View {
        if isEditing {
            LabeledTextField(label: label, placeholder: "John Doe", value: $localClient.name)
        } else {
            LabeledContent(label) {
                Text(client.name)
            }
        }
    }
    
    @ViewBuilder
    func phoneNumberField(_ label: String) -> some View {
        if isEditing {
            LabeledContent(label) {
                TextField("(555) 555-5555", text: $localClient.phoneNumber)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .onChange(of: localClient.phoneNumber, { _, newValue in
                        localClient.phoneNumber = formatPhoneNumber(newValue)
                    })
            }
        } else {
            LabeledContent(label) {
                Button {
                    let phoneLink = "tel://" + client.phoneNumber.trimmingCharacters(in: .whitespaces)
                    if let url = URL(string: phoneLink) {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    Text(client.phoneNumber)
                }
                .multilineTextAlignment(.trailing)
            }
        }
    }
    
    @ViewBuilder
    func emailField(_ label: String) -> some View {
        if isEditing {
            LabeledContent(label) {
                TextField("johndoe@gmail.com", text: $localClient.email)
                    .multilineTextAlignment(.trailing)
                    .autocorrectionDisabled(true)
                    .keyboardType(.emailAddress)
            }
        } else {
            LabeledContent(label) {
                Button {
                    let emailLink = "mailto:" + client.email
                    if let url = URL(string: emailLink) {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    Text(client.email)
                }
                .multilineTextAlignment(.trailing)
            }
        }
    }
    
    @ViewBuilder
    func addressField(_ label: String) -> some View {
        if isEditing {
            LabeledTextField(label: label, placeholder: "123 Main Street", value: $localClient.address)
        } else {
            LabeledContent(label) {
                Button {
                    let encodedAddress = client.address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                    let addressLink = "https://maps.apple.com/place?address=" + encodedAddress
                    if let url = URL(string: addressLink) {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    Text(client.address)
                }
                .multilineTextAlignment(.trailing)
            }
        }
    }
    
    @ViewBuilder
    func houseYearField(_ label: String) -> some View {
        if isEditing {
            YearPicker(title: label, selectedYear: $localClient.houseYearBuilt)
        } else {
            LabeledContent(label) {
                Text(client.houseYearBuilt.map(String.init) ?? "")
            }
        }
    }
    
    @ViewBuilder
    func gateCodeField(_ label: String) -> some View {
        if isEditing {
            LabeledTextField(label: label, placeholder: "e.g. 1234", value: $localClient.gateCode)
        } else {
            LabeledContent(label) {
                Text(client.gateCode)
            }
        }
    }
    
    @ViewBuilder
    func lotSizeField(_ label: String) -> some View {
        if isEditing {
            LabeledNumberField(label: label, placeholder: "e.g. 5000", value: $localClient.lotSqft)
        } else {
            LabeledContent(label) {
                Text(client.lotSqft)
            }
        }
        
    }
    
    @ViewBuilder
    func purchaseYearField(_ label: String) -> some View {
        if isEditing {
            YearPicker(title: label, selectedYear: $localClient.purchaseYear)
        } else {
            LabeledContent(label) {
                Text(client.purchaseYear.map(String.init) ?? "")
            }
        }
    }
    
    @ViewBuilder
    func foundUsField(_ label: String) -> some View {
        if isEditing {
            OptionPicker(label: label, selection: $localClient.foundUs)
        } else {
            LabeledContent(label) {
                Text(client.foundUs?.rawValue ?? "")
            }
        }
    }
    
    @ViewBuilder
    func phoneEstimateField(_ label: String) -> some View {
        if isEditing {
            LabeledNumberField(label: label, placeholder: "$$$", value: $localClient.phoneEstimate)
        } else {
            LabeledContent(label) {
                Text(client.phoneEstimate)
            }
        }
    }
    
    @ViewBuilder
    func notesField() -> some View {
        if isEditing {
            TextEditor(text: $localClient.notes)
        } else {
            Text(client.notes)
        }
    }
    
    // Helper function to format the phone number
    private func formatPhoneNumber(_ phoneNumber: String) -> String {
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
