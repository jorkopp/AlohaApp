//
//  Client+SiteAssessment.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import Foundation

extension Client {
    struct SiteAssessment: Codable, Equatable, Hashable {
        var plantDensity: PlantDensity?
        var plants: String = ""
        var lights: String = ""
        var access: AccessDifficulty?
        var valves: String = ""
        var backflowValve: Bool = false
        var timer: Timer?
        var demo: String = ""
        var coupon: Bool = false
        var hasGrass: Bool = false
        var plantPackage: String = ""
        var rockRefresh: String = ""
        var requests: String = ""
        var notes: String = ""
    }
}

extension Client {
    enum PlantDensity: String, CaseIterable, Identifiable, Codable {
        case High
        case Medium
        case Low
        
        var id: String { self.rawValue }
    }
        
    enum AccessDifficulty: String, CaseIterable, Identifiable, Codable {
        case Easy
        case Hard
        
        var id: String { self.rawValue }
    }

    enum Timer: String, CaseIterable, Identifiable, Codable {
        case Xcore
        case Hydrawise
        
        var id: String { self.rawValue }
    }
}
