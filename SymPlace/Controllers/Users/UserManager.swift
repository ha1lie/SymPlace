//
//  UserManager.swift
//  SymPlace
//
//  Created by Hallie on 11/6/21.
//

import Foundation
import MapKit

class UserManager: ObservableObject {
    
    private let appUserDefaults: String = "appUserStorage"
    private let defaults = UserDefaults.standard
    
    static let shared: UserManager = UserManager()
    
    @Published var currentUser: User? = nil
    
    public func createNewUser(_ user: User) async {
        print("User manager making user: \(user.name)")
        
        //Send the user's information to the server to store
        let serverURL = URL(string: "https://api.halz.dev/safe-place/new-user")!
        var newUserReq = URLRequest(url: serverURL)
        newUserReq.httpMethod = "POST"
        newUserReq.httpBody = user.jsonUser()
        newUserReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
        newUserReq.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: newUserReq) { data, response, error in
            print("URL SESSION RESPONSE")
            guard error == nil else {
                print("COULDNT MAKE NEW USER ON SERVER")
                print("ERROR: \(error.debugDescription)")
                return
            }
            
            guard let _ = data else {
                print("DIDNT RETURN ANY DATA")
                return
            }
            
            print("USER WAS MADE ON SERVER WITHOUT AN ERROR AND THE DATA IS NOT NIL")
        }.resume()
        
        print("DID THE SERVER THING")
        
        //Set the current user in the userdefaults
        
        defaults.set(try? JSONEncoder().encode(user), forKey: self.appUserDefaults)
        
        //Set the current user for this structure
        DispatchQueue.main.async {
            self.currentUser = user
        }
    }
    
    public func getName() {
        
    }
    
    public func needsMakeUser() -> Bool {
        return defaults.object(forKey: self.appUserDefaults) == nil
    }
    
    public func launchSetup() {
        print("USER MANAGER LAUNCH SETUP RUNNING")
        
        if let UDUsr = defaults.data(forKey: self.appUserDefaults) {
            self.currentUser = try? JSONDecoder().decode(User.self, from: UDUsr)
        }
        
    }
}
