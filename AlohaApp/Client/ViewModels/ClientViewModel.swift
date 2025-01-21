//
//  ClientViewModel.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import Foundation
import Firebase

@Observable
class ClientViewModel: Hashable {
    var id: String
    var name: String
    var phoneNumber: String

    private let ref = Database.database().reference(withPath: "clients")
    
    init(id: String, name: String, phoneNumber: String) {
        self.id = id
        self.name = name
        self.phoneNumber = phoneNumber
    }
    
    static func newClientViewModel() -> ClientViewModel {
        ClientViewModel(id: UUID().uuidString, name: "", phoneNumber: "")
    }
    
    var isValid: Bool {
        let isValid = name.count > 0 && phoneNumber.count == 14 // including () -
        return isValid
    }
    
    func saveChanges() {
        ref.child(id).setValue([
            "name": name,
            "phoneNumber": phoneNumber]
        )
    }
    
    func delete() {
        ref.child(id).removeValue()
    }
    
    static func == (lhs: ClientViewModel, rhs: ClientViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    var phone: Int?
//    var email: String?
//    var address: String?
//    var houseYear: Int?
//    var gateCode: Int?
//    var lotSqft: Int?
//    var purchaseYear: Int?
//    var foundUs: String?
//    var phoneEstimate: Int?
//    var notes: String?
    
//    init(name: String?, phone: Int?, email: String?, address: String?, houseYear: Int?, gateCode: Int?, lotSqft: Int?, purchaseYear: Int?, foundUs: String?, phoneEstimate: Int?, notes: String?) {
//        self.name = name
//        self.phone = phone
//        self.email = email
//        self.address = address
//        self.houseYear = houseYear
//        self.gateCode = gateCode
//        self.lotSqft = lotSqft
//        self.purchaseYear = purchaseYear
//        self.foundUs = foundUs
//        self.phoneEstimate = phoneEstimate
//        self.notes = notes
//    }
