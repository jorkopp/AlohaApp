//
//  Client.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import Foundation
import FirebaseFirestore

extension Client {
    struct Model: Item {
        static var name = "client"
        static var collectionPath = "clients"
        
        @DocumentID var id: String?
        var contactInfo = ContactInfo()
        var siteAssessment = SiteAssessment()
        var jobChecklist = JobChecklist()
        
        static func newItem() -> Model { Model() }
        
        static func sort(lhs: Model, rhs: Model) -> Bool {
            return lhs.contactInfo.name < rhs.contactInfo.name
        }
    }
}
