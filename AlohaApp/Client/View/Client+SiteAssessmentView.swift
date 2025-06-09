//
//  Client+SiteAssessmentView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import Foundation
import SwiftUI

extension Client {
    @MainActor
    struct SiteAssessmentView: View {
        @Environment(\.editMode) private var editMode
        
        @Binding var siteAssessment: SiteAssessment
        
        var body: some View {
            Form {
                Section(header: Text("Site Details")) {
                    plantDensityField("Plant Density")
                    plantsField("Plants")
                    accessDifficultyField("Access Difficulty")
                    hasGrassField("Grass")
                    timerField("Timer Type")
                    valvesField("Valves")
                    backflowValveField("Backflow Valve")
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
                Section(header: Text("Notes")) {
                    notesField()
                }
            }
        }
        
        @ViewBuilder
        func plantDensityField(_ label: String) -> some View {
            if editMode.isEditing {
                OptionPicker(label: label, selection: $siteAssessment.plantDensity)
            } else {
                LabeledContent(label) {
                    Text(siteAssessment.plantDensity?.rawValue ?? "")
                }
            }
        }
        
        @ViewBuilder
        func plantsField(_ label: String) -> some View {
            if editMode.isEditing {
                LabeledNumberField(label: label, placeholder: label, value: $siteAssessment.plants)
            } else {
                LabeledContent(label) {
                    Text(siteAssessment.plants)
                }
            }
        }
        
        @ViewBuilder
        func lightsField(_ label: String) -> some View {
            if editMode.isEditing {
                LabeledNumberField(label: label, placeholder: label, value: $siteAssessment.lights)
            } else {
                LabeledContent(label) {
                    Text(siteAssessment.lights)
                }
            }
        }
        
        @ViewBuilder
        func accessDifficultyField(_ label: String) -> some View {
            if editMode.isEditing {
                OptionPicker(label: label, selection: $siteAssessment.access)
            } else {
                LabeledContent(label) {
                    Text(siteAssessment.access?.rawValue ?? "")
                }
            }
        }
        
        @ViewBuilder
        func hasGrassField(_ label: String) -> some View {
            if editMode.isEditing {
                Toggle(label, isOn: $siteAssessment.hasGrass)
            } else {
                Toggle(label, isOn: $siteAssessment.hasGrass)
                    .disabled(true)
            }
        }
        
        @ViewBuilder
        func valvesField(_ label: String) -> some View {
            if editMode.isEditing {
                LabeledNumberField(label: label, placeholder: label, value: $siteAssessment.valves)
            } else {
                LabeledContent(label) {
                    Text(siteAssessment.valves)
                }
            }
        }
        
        @ViewBuilder
        func backflowValveField(_ label: String) -> some View {
            if editMode.isEditing {
                Toggle(label, isOn: $siteAssessment.backflowValve)
            } else {
                Toggle(label, isOn: $siteAssessment.backflowValve)
                    .disabled(true)
            }
        }
        
        @ViewBuilder
        func timerField(_ label: String) -> some View {
            if editMode.isEditing {
                OptionPicker(label: label, selection: $siteAssessment.timer)
            } else {
                LabeledContent(label) {
                    Text(siteAssessment.timer?.rawValue ?? "")
                }
            }
        }
        
        @ViewBuilder
        func couponField(_ label: String) -> some View {
            if editMode.isEditing {
                Toggle(label, isOn: $siteAssessment.coupon)
            } else {
                Toggle(label, isOn: $siteAssessment.coupon)
                    .disabled(true)
            }
        }
        
        @ViewBuilder
        func plantPackageField() -> some View {
            if editMode.isEditing {
                TextEditor(text: $siteAssessment.plantPackage)
            } else {
                Text(siteAssessment.plantPackage)
            }
        }
        
        @ViewBuilder
        func rockRefreshField() -> some View {
            if editMode.isEditing {
                TextEditor(text: $siteAssessment.rockRefresh)
            } else {
                Text(siteAssessment.rockRefresh)
            }
        }
        
        @ViewBuilder
        func demoField() -> some View {
            if editMode.isEditing {
                TextEditor(text: $siteAssessment.demo)
            } else {
                Text(siteAssessment.demo)
            }
        }
        
        @ViewBuilder
        func requestsField() -> some View {
            if editMode.isEditing {
                TextEditor(text: $siteAssessment.requests)
            } else {
                Text(siteAssessment.requests)
            }
        }
        
        @ViewBuilder
        func notesField() -> some View {
            if editMode.isEditing {
                TextEditor(text: $siteAssessment.notes)
            } else {
                Text(siteAssessment.notes)
            }
        }
    }
}

#Preview {
    ContentView()
}
