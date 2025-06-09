//
//  Client+ContactInfoView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 6/6/25.
//

import Foundation
import SwiftUI

extension Client {
    @MainActor
    struct ContactInfoView: View {
        @Environment(\.editMode) private var editMode
        
        @Binding var contactInfo: ContactInfo
        
        var body: some View {
            Form {
                Section(header: Text("Contact Info")) {
                    nameField("Name")
                    phoneNumberField("Phone")
                    emailField("Email")
                    foundUsField("Found Us")
                    activeField("Active")
                }
                Section(header: Text("Property Address")) {
                    addressField()
                }
                Section(header: Text("Property Info")) {
                    houseYearField("House Year Built")
                    purchaseYearField("Purchase Year")
                    lotSizeField("Lot Size (sq ft)")
                    gateCodeField("Gate Code")
                    signOnSiteField("Sign on Site")
                    phoneEstimateField("Phone Estimate ($)")
                }
                Section(header: Text("Notes")) {
                    notesField()
                }
            }
        }
        
        @ViewBuilder
        func nameField(_ label: String) -> some View {
            if editMode.isEditing {
                LabeledTextField(label: label, placeholder: label, value: $contactInfo.name)
            } else {
                LabeledContent(label) {
                    Text(contactInfo.name)
                }
            }
        }
        
        @ViewBuilder
        func phoneNumberField(_ label: String) -> some View {
            if editMode.isEditing {
                LabeledContent(label) {
                    TextField(label, text: $contactInfo.phoneNumber)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.numberPad)
                        .onChange(of: contactInfo.phoneNumber, { _, newValue in
                            contactInfo.phoneNumber = formatPhoneNumber(newValue)
                        })
                }
            } else {
                LabeledContent(label) {
                    Button {
                        let phoneLink = "tel://" + contactInfo.phoneNumber.trimmingCharacters(in: .whitespaces)
                        if let url = URL(string: phoneLink) {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        Text(contactInfo.phoneNumber)
                    }
                    .multilineTextAlignment(.trailing)
                }
            }
        }
        
        @ViewBuilder
        func emailField(_ label: String) -> some View {
            if editMode.isEditing {
                LabeledContent(label) {
                    TextField(label, text: $contactInfo.email)
                        .multilineTextAlignment(.trailing)
                        .autocorrectionDisabled(true)
                        .keyboardType(.emailAddress)
                }
            } else {
                LabeledContent(label) {
                    Button {
                        let emailLink = "mailto:" + contactInfo.email
                        if let url = URL(string: emailLink) {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        Text(contactInfo.email)
                    }
                    .multilineTextAlignment(.trailing)
                }
            }
        }
        
        @ViewBuilder
        func activeField(_ label: String) -> some View {
            if editMode.isEditing {
                Toggle(label, isOn: $contactInfo.active)
            } else {
                Toggle(label, isOn: $contactInfo.active)
                    .disabled(true)
            }
        }
        
        @ViewBuilder
        func addressField() -> some View {
            if editMode.isEditing {
                TextEditor(text: $contactInfo.address)
            } else {
                Button {
                    let encodedAddress = contactInfo.address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                    let addressLink = "https://maps.apple.com/place?address=" + encodedAddress
                    if let url = URL(string: addressLink) {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    Text(contactInfo.address)
                }
            }
        }
        
        @ViewBuilder
        func houseYearField(_ label: String) -> some View {
            if editMode.isEditing {
                YearPicker(title: label, selectedYear: $contactInfo.houseYearBuilt)
            } else {
                LabeledContent(label) {
                    Text(contactInfo.houseYearBuilt.map(String.init) ?? "")
                }
            }
        }
        
        @ViewBuilder
        func gateCodeField(_ label: String) -> some View {
            if editMode.isEditing {
                LabeledTextField(label: label, placeholder: label, value: $contactInfo.gateCode)
            } else {
                LabeledContent(label) {
                    Text(contactInfo.gateCode)
                }
            }
        }
        
        @ViewBuilder
        func signOnSiteField(_ label: String) -> some View {
            if editMode.isEditing {
                Toggle(label, isOn: $contactInfo.signOnSite)
            } else {
                Toggle(label, isOn: $contactInfo.signOnSite)
                    .disabled(true)
            }
        }
        
        @ViewBuilder
        func lotSizeField(_ label: String) -> some View {
            if editMode.isEditing {
                LabeledNumberField(label: label, placeholder: label, value: $contactInfo.lotSqft)
            } else {
                LabeledContent(label) {
                    Text(contactInfo.lotSqft)
                }
            }
        }
        
        @ViewBuilder
        func purchaseYearField(_ label: String) -> some View {
            if editMode.isEditing {
                YearPicker(title: label, selectedYear: $contactInfo.purchaseYear)
            } else {
                LabeledContent(label) {
                    Text(contactInfo.purchaseYear.map(String.init) ?? "")
                }
            }
        }
        
        @ViewBuilder
        func foundUsField(_ label: String) -> some View {
            if editMode.isEditing {
                OptionPicker(label: label, selection: $contactInfo.foundUs)
            } else {
                LabeledContent(label) {
                    Text(contactInfo.foundUs?.rawValue ?? "")
                }
            }
        }
        
        @ViewBuilder
        func phoneEstimateField(_ label: String) -> some View {
            if editMode.isEditing {
                LabeledNumberField(label: label, placeholder: label, value: $contactInfo.phoneEstimate)
            } else {
                LabeledContent(label) {
                    Text(contactInfo.phoneEstimate)
                }
            }
        }
        
        @ViewBuilder
        func notesField() -> some View {
            if editMode.isEditing {
                TextEditor(text: $contactInfo.notes)
            } else {
                Text(contactInfo.notes)
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
}

#Preview {
    ContentView()
}
