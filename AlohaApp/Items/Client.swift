//
//  Client.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import Foundation
import Firebase

public enum FoundUs: String, CaseIterable, Identifiable, Codable {
    case Google
    case Referral
    case Other
    
    public var id: String { self.rawValue }
}

@Observable
final public class Client: Item, Codable, Hashable {
    public static var refPath = "clients"
    
    public var uuid: String
    
    // Contact info
    public var name: String
    public var phoneNumber: String
    public var email: String
    public var address: String
    
    // Property info
    public var houseYearBuilt: Int?
    public var purchaseYear: Int?
    public var lotSqft: String
    public var gateCode: String
    
    // Misc
    public var foundUs: FoundUs?
    public var phoneEstimate: String
    public var notes: String
    
    enum CodingKeys: String, CodingKey {
        case uuid, name, phoneNumber, email, address, houseYearBuilt, purchaseYear, lotSqft, gateCode, foundUs, phoneEstimate, notes
    }
    
    public init(uuid: String, name: String, phoneNumber: String, email: String, address: String, houseYearBuilt: Int?, purchaseYear: Int?, lotSqft: String, gateCode: String, foundUs: FoundUs?, phoneEstimate: String, notes: String) {
        self.uuid = uuid
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.address = address
        self.houseYearBuilt = houseYearBuilt
        self.purchaseYear = purchaseYear
        self.lotSqft = lotSqft
        self.gateCode = gateCode
        self.foundUs = foundUs
        self.phoneEstimate = phoneEstimate
        self.notes = notes
    }
    
    public static func newItem() -> Client {
        Client(uuid: UUID().uuidString, name: "", phoneNumber: "", email: "", address: "", houseYearBuilt: nil, purchaseYear: nil, lotSqft: "", gateCode: "", foundUs: nil, phoneEstimate: "", notes: "")
    }
    
    public func isValid() -> Bool {
        !name.isEmpty && !phoneNumber.isEmpty && !email.isEmpty && !address.isEmpty
    }
    
    // MARK: Sortable
    
    public static func sort(lhs: Client, rhs: Client) -> Bool {
        return lhs.name < rhs.name
    }
    
    // MARK: Hashable
    
    public static func == (lhs: Client, rhs: Client) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    
    // MARK: Codable
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.uuid = try container.decode(String.self, forKey: .uuid)
        self.name = try container.decode(String.self, forKey: .name)
        self.phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        self.email = try container.decode(String.self, forKey: .email)
        self.address = try container.decode(String.self, forKey: .address)
        self.houseYearBuilt = try container.decodeIfPresent(Int.self, forKey: .houseYearBuilt)
        self.purchaseYear = try container.decodeIfPresent(Int.self, forKey: .purchaseYear)
        self.lotSqft = try container.decode(String.self, forKey: .lotSqft)
        self.gateCode = try container.decode(String.self, forKey: .gateCode)
        self.foundUs = try container.decodeIfPresent(FoundUs.self, forKey: .foundUs)
        self.phoneEstimate = try container.decode(String.self, forKey: .phoneEstimate)
        self.notes = try container.decode(String.self, forKey: .notes)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uuid, forKey: .uuid)
        try container.encode(name, forKey: .name)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(email, forKey: .email)
        try container.encode(address, forKey: .address)
        try container.encodeIfPresent(houseYearBuilt, forKey: .houseYearBuilt)
        try container.encodeIfPresent(purchaseYear, forKey: .purchaseYear)
        try container.encode(lotSqft, forKey: .lotSqft)
        try container.encode(gateCode, forKey: .gateCode)
        try container.encodeIfPresent(foundUs, forKey: .foundUs)
        try container.encode(phoneEstimate, forKey: .phoneEstimate)
        try container.encode(notes, forKey: .notes)
    }
    
    // MARK: Updatable
    
    @MainActor
    public func update(from other: Client) {
        updateIfDifferent(&name, newValue: other.name)
        updateIfDifferent(&phoneNumber, newValue: other.phoneNumber)
        updateIfDifferent(&email, newValue: other.email)
        updateIfDifferent(&address, newValue: other.address)
        updateIfDifferent(&houseYearBuilt, newValue: other.houseYearBuilt)
        updateIfDifferent(&purchaseYear, newValue: other.purchaseYear)
        updateIfDifferent(&lotSqft, newValue: other.lotSqft)
        updateIfDifferent(&gateCode, newValue: other.gateCode)
        updateIfDifferent(&phoneEstimate, newValue: other.phoneEstimate)
        updateIfDifferent(&foundUs, newValue: other.foundUs)
        updateIfDifferent(&notes, newValue: other.notes)
    }
}
