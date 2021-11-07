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
    @ObservedObject var informationManager: InformationManager = .shared
    @ObservedObject var locationManager: LocationManager = .shared
    
    var body: some View {
        if self.onboardController.hasOnboarded {
            if self.userManager.currentUser == nil {
                NewUserScreen()
            } else {
                VStack {
                    MainScreen()
                }.sheet(isPresented: $informationManager.presentReviewSheet) {
                    print("DISMISS THE REVIEW SHEET")
                } content: {
                    InformationCollectionView()
                }

            }
        } else {
            OnboardingScreen()
        }
    }
}
