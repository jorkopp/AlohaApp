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
            case .contactInfo: return "CONTACT INFO"
            case .siteAssessment: return "SITE ASSESSMENT"
            case .jobChecklist: return "JOB CHECKLIST"
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
            Group {
                DetailsTabView(selectedTab: $selectedTab)
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
    
    struct DetailsTabView: View {
        @Binding var selectedTab: DetailsTab
        @Namespace var name

        var body: some View {
            HStack(spacing: 0) {
                ForEach(DetailsTab.allCases, id: \.self) { tab in
                    tabButton(for: tab)
                }
            }
        }
        
        @ViewBuilder
        func tabButton(for tab: DetailsTab) -> some View {
            Button {
                selectedTab = tab
            } label: {
                VStack {
                    title(for: tab)
                    selectionIndicator(for: tab)
                }
            }
        }

        @ViewBuilder
        func title(for tab: DetailsTab) -> some View {
            Text(tab.title)
                .font(.footnote)
                .fontWeight(.medium)
                .foregroundColor(tab == selectedTab ? .primary : .secondary)
        }
        
        @ViewBuilder
        func selectionIndicator(for tab: DetailsTab) -> some View {
            ZStack {
                Capsule()
                    .fill(Color.clear)
                    .frame(height: 4)
                if tab == selectedTab {
                    Capsule()
                        .fill(Color.primary)
                        .frame(height: 4)
                        .matchedGeometryEffect(id: "Tab", in: name)
                }
            }
        }
    }
}

#Preview {
    StatefulPreviewWrapper(Client.Model(contactInfo: Client.ContactInfo(name: "Test Client"))) { binding in
        Client.DetailsView(clientModel: binding, inventoryItemNames: [])
    }
}
