//
//  User.swift
//  SymPlace
//
//  Created by Hallie on 11/6/21.
//

import Foundation

struct User: Codable, Hashable {
    let name: String
    let gender: Gender
    let race: Race
    let state: String
    let city: String
    let sexuality: Sexuality
    
    func jsonUser() -> Data? {
        // Returns the json version of the object
        return try? JSONEncoder().encode(self)
    }
    
    static func userFromJson(user: Data) -> User? {
        return try? JSONDecoder().decode(User.self, from: user)
    }
}
