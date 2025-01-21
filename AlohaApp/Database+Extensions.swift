//
//  Database+Extensions.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 1/20/25.
//

import FirebaseDatabase

extension Database {
  class var root: DatabaseReference {
    return database().reference()
  }
}

extension DataSnapshot {
    var valueAsDictionary: [String: Any] {
        return value as! [String: Any]
    }
}
