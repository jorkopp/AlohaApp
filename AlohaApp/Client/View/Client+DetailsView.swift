//
//  Client+DetailsView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import Foundation
import SwiftUI

extension Client {
    enum DetailsTab: Int, CaseIterable, Identifiable {
        case contactInfo
        case siteAssessment
        case jobChecklist
        
        var id: Int { self.rawValue }
        
        var title: String {
            switch self {
            case .contactInfo: return "Contact Info"
            case .siteAssessment: return "Site Assessment"
            case .jobChecklist: return "Job Checklist"
            }
        }
    }
    
    @MainActor
    struct DetailsView: View {
        @Environment(\.editMode) private var editMode
        
        @Binding var clientModel: Model
        let inventoryItemNames: [String]
        
        @State private var selectedTab: DetailsTab = .contactInfo
        
        var body: some View {
            NavigationStack {
                Picker("Client Details Section", selection: $selectedTab) {
                    ForEach(DetailsTab.allCases) { tab in
                        Text(tab.title).tag(tab)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                switch selectedTab {
                case .contactInfo:
                    ContactInfoView(contactInfo: $clientModel.contactInfo)
                case .siteAssessment:
                    SiteAssessmentView(siteAssessment: $clientModel.siteAssessment)
                case .jobChecklist:
                    JobChecklistView(checklist: $clientModel.jobChecklist, inventoryItemNames: inventoryItemNames)
                }
            }
            .navigationTitle(clientModel.contactInfo.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    StatefulPreviewWrapper(Client.Model(contactInfo: Client.ContactInfo(name: "Test Client"))) { binding in
        Client.DetailsView(clientModel: binding, inventoryItemNames: [])
    }
}
