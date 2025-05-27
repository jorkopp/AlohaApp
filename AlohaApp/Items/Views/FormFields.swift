//
//  FormFields.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 5/26/25.
//

import SwiftUI

public extension View {
    func missingFieldsAlert(isPresented: Binding<Bool>) -> some View {
        self.alert("Missing Required Fields", isPresented: isPresented) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please complete all required fields before proceeding.")
        }
    }
}

@MainActor
public struct RequiredField<Content: View>: View {
    let isEditing: Bool
    let content: () -> Content

    public var body: some View {
        ZStack(alignment: .topTrailing) {
            content()
            if isEditing {
                Text("*")
                    .foregroundColor(.red)
                    .font(.caption)
                    .offset(x: 12, y: -1)
            }
        }
    }
}

@MainActor
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

@MainActor
public struct LabeledNumberField: View {
    let label: String
    let placeholder: String
    @Binding var value: String

    public var body: some View {
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
public struct LabeledTextField: View {
    let label: String
    let placeholder: String
    @Binding var value: String

    public var body: some View {
        LabeledContent(label) {
            TextField(placeholder, text: $value)
                .multilineTextAlignment(.trailing)
        }
    }
}

@MainActor
public struct OptionPicker<T>: View where T: RawRepresentable & CaseIterable & Hashable, T.RawValue: StringProtocol {
    let label: String
    @Binding var selection: T?
    
    public var body: some View {
        Picker(label, selection: $selection) {
            Text("Select option").tag(Optional<T>.none)
            ForEach(Array(T.allCases), id: \.self) {
                Text($0.rawValue).tag(Optional($0))
            }
        }
    }
}

#Preview {
    ContentView()
}
