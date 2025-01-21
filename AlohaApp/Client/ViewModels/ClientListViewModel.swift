//
//  ClientListViewModel.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/20/25.
//

import Foundation
import Firebase

@Observable
class ClientListViewModel {
    var clientViewModelsByClientID: [String: ClientViewModel] = [:]

    private let ref = Database.database().reference(withPath: "clients")
    @ObservationIgnored
    private var refHandle: DatabaseHandle?
    
    func startFetchingClientData() {
        refHandle = ref.observe(DataEventType.value, with: { snapshot in
            let clientsData = (snapshot.valueAsDictionary as? [String: [String: Any]]) ?? [:]
            for (clientID, clientData) in clientsData {
                let name = clientData["name"] as! String
                let phoneNumber = clientData["phoneNumber"] as! String
                let client = self.clientViewModelsByClientID[clientID]
                if let client {
                    // Update existing client properties
                    if client.name != name {
                        client.name = name
                    }
                    if client.phoneNumber != phoneNumber {
                        client.phoneNumber = phoneNumber
                    }
                } else {
                    // Create ClientViewModel
                    self.clientViewModelsByClientID[clientID] = ClientViewModel(id: clientID, name: name, phoneNumber: phoneNumber)
                }
            }
            // Delete clients if needed
            let clientIDs = Set(clientsData.keys)
            let cachedClientIDs = Array(self.clientViewModelsByClientID.keys)
            for clientID in cachedClientIDs {
                if !clientIDs.contains(clientID) {
                    self.clientViewModelsByClientID.removeValue(forKey: clientID)
                }
            }
        })
    }
    
    var sortedClients: [ClientViewModel] {
        return Array(clientViewModelsByClientID.values).sorted { $0.name < $1.name }
    }
    
}
