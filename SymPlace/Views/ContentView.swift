//
//  ContentView.swift
//  SymPlace
//
//  Created by Hallie on 11/6/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var onboardController: OnboardingController = .shared
    @ObservedObject var userManager: UserManager = .shared
    
    var body: some View {
        if self.onboardController.hasOnboarded {
            if self.userManager.currentUser == nil {
                NewUserScreen()
            } else {
                MainScreen()
            }
        } else {
            OnboardingScreen()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
