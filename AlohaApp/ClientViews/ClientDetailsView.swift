//
//  ClientDetailsView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import SwiftUI

// TODO: Update all fields to use localClient when isEditing

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
                    nameField()
                }
                RequiredField(isEditing: isEditing) {
                    phoneNumberField()
                }
                RequiredField(isEditing: isEditing) {
                    emailField()
                }
                foundUsField()
            }
            Section(header: Text("Property Info")) {
                RequiredField(isEditing: isEditing) {
                    addressField()
                }
                houseYearField()
                purchaseYearField()
                lotSizeField()
                gateCodeField()
                phoneEstimateField()
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
    func nameField() -> some View {
        if isEditing {
            LabeledContent("Name") {
                TextField("Name", text: $localClient.name)
                    .multilineTextAlignment(.trailing)
                    .autocorrectionDisabled(true)
                    .autocapitalization(UITextAutocapitalizationType.words)
            }
        } else {
            LabeledContent("Name") {
                Text(client.name)
            }
        }
    }
    
    @ViewBuilder
    func phoneNumberField() -> some View {
        if isEditing {
            LabeledContent("Phone") {
                TextField("(555) 555-5555", text: $localClient.phoneNumber)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .onChange(of: client.phoneNumber, { _, newValue in
                        client.phoneNumber = formatPhoneNumber(newValue)
                    })
            }
        } else {
            LabeledContent("Phone") {
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
    func emailField() -> some View {
        if isEditing {
            LabeledContent("Email") {
                TextField("Email", text: $localClient.email)
                    .multilineTextAlignment(.trailing)
                    .autocorrectionDisabled(true)
                    .keyboardType(.emailAddress)
            }
        } else {
            LabeledContent("Email") {
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
    func addressField() -> some View {
        if isEditing {
            LabeledContent("Address") {
                TextField("Address", text: $localClient.address)
                    .autocorrectionDisabled(true)
                    .multilineTextAlignment(.trailing)
            }
        } else {
            LabeledContent("Address") {
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
    func houseYearField() -> some View {
        if isEditing {
            YearPicker(title: "House Year Built", selectedYear: $localClient.houseYearBuilt)
        } else {
            LabeledContent("House Year Built") {
                Text(client.houseYearBuilt.map(String.init) ?? "")
            }
        }
    }
    
    @ViewBuilder
    func gateCodeField() -> some View {
        if isEditing {
            LabeledContent("Gate Code") {
                TextField("e.g. 1234", text: $localClient.gateCode)
                    .multilineTextAlignment(.trailing)
            }
        } else {
            LabeledContent("Gate Code") {
                Text(client.gateCode)
            }
        }
    }
    
    @ViewBuilder
    func lotSizeField() -> some View {
        if isEditing {
            LabeledContent("Lot Size (sq ft)") {
                TextField("e.g. 5000", text: $localClient.lotSqft)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .onChange(of: client.lotSqft) { _, newValue in
                        client.lotSqft = newValue.filter { $0.isNumber }
                    }
            }
        } else {
            LabeledContent("Lot Size (sq ft)") {
                Text(client.lotSqft)
            }
        }
        
    }
    
    @ViewBuilder
    func purchaseYearField() -> some View {
        if isEditing {
            YearPicker(title: "Purchase Year", selectedYear: $localClient.purchaseYear)
        } else {
            LabeledContent("Purchase Year") {
                Text(client.purchaseYear.map(String.init) ?? "")
            }
        }
    }
    
    @ViewBuilder
    func foundUsField() -> some View {
        if isEditing {
            Picker("Found Us", selection: $localClient.foundUs) {
                Text("Select option").tag(Optional<FoundUs>.none)
                ForEach(FoundUs.allCases) {
                    Text($0.rawValue).tag(Optional($0))
                }
            }
        } else {
            LabeledContent("Found Us") {
                Text(client.foundUs?.rawValue ?? "")
            }
        }
    }
    
    @ViewBuilder
    func phoneEstimateField() -> some View {
        if isEditing {
            LabeledContent("Phone Estimate") {
                TextField("$$$", text: $localClient.phoneEstimate)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .onChange(of: client.phoneEstimate) { _, newValue in
                        client.phoneEstimate = newValue.filter { $0.isNumber }
                    }
            }
        } else {
            LabeledContent("Phone Estimate") {
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

public struct RequiredField<Content: View>: View {
    let isEditing: Bool
    let content: () -> Content

    public var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 2) {
            content()
            if isEditing {
                Text("*")
                    .foregroundColor(.red)
            }
        }
    }
}

public struct YearPicker: View {
    let title: String
    
    @Binding var selectedYear: Int?

    public var body: some View {
        Picker(title, selection: $selectedYear) {
            Text("Select year").tag(nil as Int?)
            ForEach((1800...Calendar.current.component(.year, from: Date())).reversed(), id: \.self) { year in
                Text(String(year)).tag(Optional(year))
            }
        }
    }
}

#Preview {
    ContentView()
}
