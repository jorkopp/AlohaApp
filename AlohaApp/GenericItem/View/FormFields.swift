//
//  FormFields.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 5/26/25.
//

import Foundation
import SwiftUI

@MainActor
struct YearPicker: View {
    let title: String
    @Binding var selectedYear: Int?

    var body: some View {
        Picker(title, selection: $selectedYear) {
            Text("Select year").tag(nil as Int?)
            ForEach((1800...Calendar.current.component(.year, from: Date())).reversed(), id: \.self) { year in
                Text(String(year)).tag(Optional(year))
            }
        }
    }
}

@MainActor
struct LabeledNumberField: View {
    let label: String
    let placeholder: String
    @Binding var value: String

    var body: some View {
        LabeledContent(label) {
            TextField(placeholder, text: $value)
                .multilineTextAlignment(.trailing)
                .keyboardType(.numberPad)
                .onChange(of: value) { _, newValue in
                    value = newValue.filter { $0.isNumber }
                }
        }
    }
}

@MainActor
struct LabeledTextField: View {
    let label: String
    let placeholder: String
    @Binding var value: String

    var body: some View {
        LabeledContent(label) {
            TextField(placeholder, text: $value)
                .multilineTextAlignment(.trailing)
        }
    }
}

@MainActor
struct OptionPicker<T>: View where T: RawRepresentable & CaseIterable & Hashable, T.RawValue: StringProtocol {
    let label: String
    @Binding var selection: T?
    
    var body: some View {
        Picker(label, selection: $selection) {
            Text("Select option").tag(Optional<T>.none)
            ForEach(Array(T.allCases), id: \.self) {
                Text($0.rawValue).tag(Optional($0))
            }
        }
    }
}
