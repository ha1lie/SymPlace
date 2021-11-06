//
//  OnboardingScreen.swift
//  SymPlace
//
//  Created by Hallie on 11/6/21.
//

import SwiftUI

struct OnboardingScreen: View {
    
    @ObservedObject var onboardController: OnboardingController = OnboardingController.shared
    
    @State var page: Int = 1
    
    var body: some View {
        VStack {
            Text("ONBOARDING SCREEN")
                .bold()
            
            Text("Page: \(self.page)")
                .bold()
            
            if self.page > 1 {
                Button {
                    self.page -= 1
                } label: {
                    Text("LAST PAGE")
                }
            }
            
            if self.page < 3 {
                Button {
                    self.page += 1
                } label: {
                    Text("NEXT PAGE")
                }
            }
            
            if self.page == 3 {
                Button {
                    self.onboardController.finishOnboarding()
                } label: {
                    Text("Continue")
                }
            }
        }
    }
}
