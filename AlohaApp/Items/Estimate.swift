//
//  Estimate.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import Foundation
import Firebase

public enum PlantDensity: String, CaseIterable, Identifiable, Codable {
    case High
    case Medium
    case Low
    
    public var id: String { self.rawValue }
}
    
public enum AccessDifficulty: String, CaseIterable, Identifiable, Codable {
    case Easy
    case Hard
    
    public var id: String { self.rawValue }
}

public enum Timer: String, CaseIterable, Identifiable, Codable {
    case Xcore
    case Hydrawise
    
    public var id: String { self.rawValue }
}


@Observable
final public class Estimate: Item, Codable, Hashable {
    public static var refPath = "estimates"
    
    public var uuid: String
    
    public var plantDensity: PlantDensity?
    public var lights: String
    public var access: AccessDifficulty?
    public var valves: String
    public var timer: Timer?
    public var demo: String
    public var coupon: Bool
    public var plantPackage: String
    public var rockRefresh: String
    public var requests: String
    
    enum CodingKeys: String, CodingKey {
        case uuid, plantDensity, lights, access, valves, timer, demo, coupon, plantPackage, rockRefresh, requests
    }
    
    public init(uuid: String, plantDensity: PlantDensity?, lights: String, access: AccessDifficulty?, valves: String, timer: Timer?, demo: String, coupon: Bool, plantPackage: String, rockRefresh: String, requests: String) {
        self.uuid = uuid
        self.plantDensity = plantDensity
        self.lights = lights
        self.access = access
        self.valves = valves
        self.timer = timer
        self.demo = demo
        self.coupon = coupon
        self.plantPackage = plantPackage
        self.rockRefresh = rockRefresh
        self.requests = requests
    }
    
    public static func newItem() -> Estimate {
        Estimate(uuid: UUID().uuidString, plantDensity: nil, lights: "", access: nil, valves: "", timer: nil, demo:"", coupon: false, plantPackage: "", rockRefresh: "", requests: "")
    }
    
    public func isValid() -> Bool {
        plantDensity != nil && access != nil && timer != nil && !valves.isEmpty
    }
    
    // MARK: Sortable
    
    public static func sort(lhs: Estimate, rhs: Estimate) -> Bool {
        // TODO: Probably want to store a date and sort with that?
        return lhs.uuid < rhs.uuid
    }
    
    // MARK: Hashable
    
    public static func == (lhs: Estimate, rhs: Estimate) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    
    // MARK: Codable
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.uuid = try container.decode(String.self, forKey: .uuid)
        self.plantDensity = try container.decodeIfPresent(PlantDensity.self, forKey: .plantDensity)
        self.lights = try container.decode(String.self, forKey: .lights)
        self.access = try container.decodeIfPresent(AccessDifficulty.self, forKey: .access)
        self.valves = try container.decode(String.self, forKey: .valves)
        self.timer = try container.decodeIfPresent(Timer.self, forKey: .timer)
        self.demo = try container.decode(String.self, forKey: .demo)
        self.coupon = try container.decode(Bool.self, forKey: .coupon)
        self.plantPackage = try container.decode(String.self, forKey: .plantPackage)
        self.rockRefresh = try container.decode(String.self, forKey: .rockRefresh)
        self.requests = try container.decode(String.self, forKey: .requests)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uuid, forKey: .uuid)
        try container.encodeIfPresent(plantDensity, forKey: .plantDensity)
        try container.encode(lights, forKey: .lights)
        try container.encodeIfPresent(access, forKey: .access)
        try container.encode(valves, forKey: .valves)
        try container.encodeIfPresent(timer, forKey: .timer)
        try container.encodeIfPresent(demo, forKey: .demo)
        try container.encode(coupon, forKey: .coupon)
        try container.encode(plantPackage, forKey: .plantPackage)
        try container.encodeIfPresent(rockRefresh, forKey: .rockRefresh)
        try container.encode(requests, forKey: .requests)
    }
    
    // MARK: Updateable
    
    @MainActor
    public func update(from other: Estimate) {
        updateIfDifferent(&plantDensity, newValue: other.plantDensity)
        updateIfDifferent(&lights, newValue: other.lights)
        updateIfDifferent(&access, newValue: other.access)
        updateIfDifferent(&valves, newValue: other.valves)
        updateIfDifferent(&timer, newValue: other.timer)
        updateIfDifferent(&demo, newValue: other.demo)
        updateIfDifferent(&coupon, newValue: other.coupon)
        updateIfDifferent(&plantPackage, newValue: other.plantPackage)
        updateIfDifferent(&rockRefresh, newValue: other.rockRefresh)
        updateIfDifferent(&requests, newValue: other.requests)
    }
}
