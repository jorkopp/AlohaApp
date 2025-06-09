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
                    accessDifficultyField("Access Difficulty")
                    timerField("Timer Type")
                    valvesField("Valves")
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
    }
}

#Preview {
    ContentView()
}
