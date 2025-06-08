//
//  SiteAssessment.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import Foundation
import FirebaseFirestore

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

struct SiteAssessment: Codable, Equatable, Hashable {
    var plantDensity: PlantDensity?
    var lights: String = ""
    var access: AccessDifficulty?
    var valves: String = ""
    var timer: Timer?
    var demo: String = ""
    var coupon: Bool = false
    var plantPackage: String = ""
    var rockRefresh: String = ""
    var requests: String = ""
}
