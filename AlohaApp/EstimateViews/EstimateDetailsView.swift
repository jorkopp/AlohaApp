//
//  EstimateDetailsView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import SwiftUI

// TODO: Update all fields to use localClient when isEditing
// TODO: Cleanup field UI logic

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
                    plantDensityField()
                }
                RequiredField(isEditing: isEditing) {
                    lightsField()
                }
                RequiredField(isEditing: isEditing) {
                    accessField()
                }
                valvesField()

                RequiredField(isEditing: isEditing) {
                    timerField()
                }
                demoField()
                couponField()
                plantPackageField()
                rockRefreshField()
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
    func plantDensityField() -> some View {
        if !isEditing {
            LabeledContent("Plant Density") {
                Text(estimate.plantDensity?.rawValue ?? "")
            }
        } else {
            Picker("Plant Density", selection: $localEstimate.plantDensity) {
                Text("Select option").tag(Optional<PlantDensity>.none)
                ForEach(PlantDensity.allCases) {
                    Text($0.rawValue).tag(Optional($0))
                }
            }
        }
    }
    
    @ViewBuilder
    func lightsField() -> some View {
        if !isEditing {
            LabeledContent("Lights Quantity") {
                Text(estimate.lights.map(String.init) ?? "")
            }
        } else {
            LightsPicker(title: "Lights Quantity", selectedLights: $localEstimate.lights)
        }
    }
    
    @ViewBuilder
    func accessField() -> some View {
        if !isEditing {
            LabeledContent("Access Difficulty") {
                Text(estimate.access?.rawValue ?? "")
            }
        } else {
            Picker("Access Difficulty", selection: $localEstimate.access) {
                Text("Select option").tag(Optional<Difficulty>.none)
                ForEach(Difficulty.allCases) {
                    Text($0.rawValue).tag(Optional($0))
                }
            }
        }
    }
    
    @ViewBuilder
    func valvesField() -> some View {
        if !isEditing {
            LabeledContent("Valves Quantity") {
                Text(estimate.valves.map(String.init) ?? "")
            }
        } else {
            ValvesPicker(title: "Valves Quantity", selectedValves: $localEstimate.valves)
        }
    }
    
    @ViewBuilder
    func timerField() -> some View {
        if !isEditing {
            LabeledContent("Timer Type") {
                Text(estimate.timer?.rawValue ?? "")
            }
        } else {
            Picker("Timer Type", selection: $localEstimate.timer) {
                Text("Select option").tag(Optional<Timer>.none)
                ForEach(Timer.allCases) {
                    Text($0.rawValue).tag(Optional($0))
                }
            }
        }
    }
    
    @ViewBuilder
    func demoField() -> some View {
        if !isEditing {
            LabeledContent("Demo") {
                Text(estimate.demo)
            }
        } else {
            LabeledContent("Plant Package") {
                TextEditor(text: $localEstimate.demo)
            }
        }
    }
    
    @ViewBuilder
    func couponField() -> some View {
        if !isEditing {
            LabeledContent("Coupon") {
                Text(estimate.coupon)
            }
        } else {
            LabeledContent("Plant Package") {
                TextEditor(text: $localEstimate.coupon)
            }
        }
    }
    
    @ViewBuilder
    func plantPackageField() -> some View {
        if !isEditing {
            LabeledContent("Plant Package") {
                Text(estimate.plantPackage)
            }
        } else {
            LabeledContent("Plant Package") {
                TextEditor(text: $localEstimate.plantPackage)
            }
        }
    }
    
    @ViewBuilder
    func rockRefreshField() -> some View {
        if !isEditing {
            LabeledContent("Rock Refresh") {
                Text(estimate.rockRefresh)
            }
        } else {
            LabeledContent("Rock Refresh") {
                TextEditor(text: $localEstimate.rockRefresh)
            }
        }
    }
    
    @ViewBuilder
    func requestsField() -> some View {
        if !isEditing {
            LabeledContent("Requests") {
                Text(estimate.requests)
            }
        } else {
            LabeledContent("Requests") {
                TextEditor(text: $localEstimate.requests)
            }
        }
    }
}

public struct LightsPicker: View {
    let title: String
    
    @Binding var selectedLights: Int?

    public var body: some View {
        // TODO: Can make .pickerStyle(WheelPickerStyle())
        //       or even use a +/- UI?
        Picker(title, selection: $selectedLights) {
            Text("Select number of lights").tag(nil as Int?)

            ForEach(1...99, id: \.self) { number in
                Text("\(number)").tag(number as Int?)
            }
        }
    }
}

public struct ValvesPicker: View {
    let title: String
    
    @Binding var selectedValves: Int?

    public var body: some View {
        Picker(title, selection: $selectedValves) {
            Text("Select number of valves").tag(nil as Int?)

            ForEach(1...99, id: \.self) { number in
                Text("\(number)").tag(number as Int?)
            }
        }
    }
}

#Preview {
    ContentView()
}
