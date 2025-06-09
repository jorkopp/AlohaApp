//
//  Client+ContactInfo.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 6/8/25.
//

import Foundation

extension Client {
    struct ContactInfo: Codable, Equatable, Hashable {
        var active: Bool = true
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
        var signOnSite: Bool = false
        var notes: String = ""
    }
}

extension Client {
    enum FoundUs: String, CaseIterable, Identifiable, Codable {
        case Google
        case Referral
        case Other
        
        var id: String { self.rawValue }
    }
}

