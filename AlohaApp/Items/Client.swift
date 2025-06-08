//
//  Client.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import Foundation
import FirebaseFirestore

enum FoundUs: String, CaseIterable, Identifiable, Codable {
    case Google
    case Referral
    case Other
    
    var id: String { self.rawValue }
}

struct Client: Item {
    static var collectionPath = "clients"
    
    @DocumentID var id: String?
    
    var name: String = ""
    var phoneNumber: String = ""
    var email: String = ""
    var address: String = ""
    var houseYearBuilt: Int?
    var purchaseYear: Int?
    var lotSqft: String = ""
    var gateCode: String = ""
    var foundUs: FoundUs?
    var phoneEstimate: String = ""
    var notes: String = ""
    var siteAssessment: SiteAssessment = SiteAssessment()
    
    static func newItem() -> Client {
        Client()
    }
    
    // MARK: Sortable
    
    static func sort(lhs: Client, rhs: Client) -> Bool {
        return lhs.name < rhs.name
    }
}
