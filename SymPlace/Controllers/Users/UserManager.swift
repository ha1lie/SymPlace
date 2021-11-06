//
//  UserManager.swift
//  SymPlace
//
//  Created by Hallie on 11/6/21.
//

import Foundation
import MapKit

class UserManager {
    
    private let appUserDefaults: String = "appUserStorage"
    private let defaults = UserDefaults.standard
    
    static let shred: UserManager = UserManager()
    
    private let currentUser: User? = nil
    
    public func createNewUser(_ user: User) {
        print(user.name)
    }
    
    public func getName() {
        
    }
    
    public func needsMakeUser() -> Bool {
        return defaults.object(forKey: self.appUserDefaults) == nil
    }
}
