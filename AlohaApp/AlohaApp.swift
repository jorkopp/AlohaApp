//
//  AlohaApp.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/19/25.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase

//Firebase communication
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct AlohaApp: App {

    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

//open class HashableClass {
//    public init() {}
//}
//
//extension HashableClass: Hashable {
//
//    public func hash(into hasher: inout Hasher) {
//         hasher.combine(ObjectIdentifier(self))
//    }
//}
//
//extension HashableClass: Equatable {
//
//    public static func ==(lhs: HashableClass, rhs: HashableClass) -> Bool {
//        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
//    }
//}
