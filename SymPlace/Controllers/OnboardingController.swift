//
//  OnboardingController.swift
//  SymPlace
//
//  Created by Hallie on 11/6/21.
//

import Foundation
import SwiftUI

class OnboardingController: ObservableObject {
    static let shared: OnboardingController = OnboardingController()
    
    @Published var hasOnboarded: Bool = false
    
    private let onboardingFinishedDefaults: String = "onboardingComplete"
    
    func finishOnboarding() {
        self.hasOnboarded = true
        UserDefaults.standard.set(true, forKey: self.onboardingFinishedDefaults)
    }
    
    func undoOnboardComplete() {
        self.hasOnboarded = false
        UserDefaults.standard.set(false, forKey: self.onboardingFinishedDefaults)
    }
    
    public func launchSetup() {
        self.hasOnboarded = UserDefaults.standard.bool(forKey: self.onboardingFinishedDefaults)
    }
}
