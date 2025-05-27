//
//  EstimateDetailsView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import SwiftUI

@MainActor
struct EstimateDetailsView: View {
    @Environment(\.editMode) private var editMode
    
    private var isEditing: Bool {
        editMode?.wrappedValue.isEditing ?? false
    }
    
    @Bindable var estimate: Estimate
    @State private var localEstimate: Estimate
    
    public init(estimate: Estimate) {
        self.estimate = estimate
        _localEstimate = State(initialValue: estimate)
    }
    
    var body: some View {
        Form {
            Section(header: Text("Site Details")) {
                RequiredField(isEditing: isEditing) {
                    plantDensityField("Plant Density")
                }
                RequiredField(isEditing: isEditing) {
                    accessDifficultyField("Access Difficulty")
                }
                RequiredField(isEditing: isEditing) {
                    timerField("Timer Type")
                }
                RequiredField(isEditing: isEditing) {
                    valvesField("Valves")
                }
                lightsField("Lights")
                couponField("Coupon")
            }
            Section(header: Text("Demo")) {
                demoField()
            }
            Section(header: Text("Plant Package")) {
                plantPackageField()
            }
            Section(header: Text("Rock Refresh")) {
                rockRefreshField()
            }
            Section(header: Text("Requests")) {
                requestsField()
            }
        }
        .onChange(of: isEditing) { oldValue, newValue in
            guard oldValue != newValue else { return }
            if !newValue && oldValue {
                estimate.update(from: localEstimate)
            }
        }
        .onChange(of: estimate) { _, newValue in
            if !isEditing {
                localEstimate = newValue
            }
        }
    }
    
    @ViewBuilder
    func plantDensityField(_ label: String) -> some View {
        if isEditing {
            OptionPicker(label: label, selection: $localEstimate.plantDensity)
        } else {
            LabeledContent(label) {
                Text(estimate.plantDensity?.rawValue ?? "")
            }
        }
    }
    
    @ViewBuilder
    func lightsField(_ label: String) -> some View {
        if isEditing {
            LabeledNumberField(label: label, placeholder: "e.g. 5", value: $localEstimate.lights)
        } else {
            LabeledContent(label) {
                Text(estimate.lights)
            }
        }
    }
    
    @ViewBuilder
    func accessDifficultyField(_ label: String) -> some View {
        if isEditing {
            OptionPicker(label: label, selection: $localEstimate.access)
        } else {
            LabeledContent(label) {
                Text(estimate.access?.rawValue ?? "")
            }
        }
    }
    
    @ViewBuilder
    func valvesField(_ label: String) -> some View {
        if isEditing {
            LabeledNumberField(label: label, placeholder: "e.g. 5", value: $localEstimate.valves)
        } else {
            LabeledContent(label) {
                Text(estimate.valves)
            }
        }
    }
    
    @ViewBuilder
    func timerField(_ label: String) -> some View {
        if isEditing {
            OptionPicker(label: label, selection: $localEstimate.timer)
        } else {
            LabeledContent(label) {
                Text(estimate.timer?.rawValue ?? "")
            }
        }
    }
    
    @ViewBuilder
    func couponField(_ label: String) -> some View {
        if isEditing {
            Toggle(label, isOn: $localEstimate.coupon)
        } else {
            Toggle(label, isOn: $estimate.coupon)
                .disabled(true)
        }
    }
    
    @ViewBuilder
    func plantPackageField() -> some View {
        if isEditing {
            TextEditor(text: $localEstimate.plantPackage)
        } else {
            Text(estimate.plantPackage)
        }
    }
    
    @ViewBuilder
    func rockRefreshField() -> some View {
        if isEditing {
            TextEditor(text: $localEstimate.rockRefresh)
        } else {
            Text(estimate.rockRefresh)
        }
    }
    
    @ViewBuilder
    func demoField() -> some View {
        if isEditing {
            TextEditor(text: $localEstimate.demo)
        } else {
            Text(estimate.demo)
        }
    }
    
    @ViewBuilder
    func requestsField() -> some View {
        if isEditing {
            TextEditor(text: $localEstimate.requests)
        } else {
            Text(estimate.requests)
        }
    }
}

#Preview {
    ContentView()
}
