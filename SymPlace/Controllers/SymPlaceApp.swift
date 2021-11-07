//
//  SymPlaceApp.swift
//  SymPlace
//
//  Created by Hallie on 11/6/21.
//

import SwiftUI

@main
struct SymPlaceApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    
    private let defaultsRegisterSuccess: String = "successfullyGotToken"
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UserManager.shared.launchSetup()
        LocationManager.shared.launchSetup()
        NotificationManager.shared.launchSetup()
        OnboardingController.shared.launchSetup()
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //The function that runs when it successfully registers for it
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        let token = tokenParts.joined()
        UserDefaults.standard.set(token, forKey: "deviceTokenToSendToServer")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // The function run when the app fails to register
        print("FAILED TO REGISTER")
        UserDefaults.standard.set(false, forKey: self.defaultsRegisterSuccess)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print("Received push notification: \(userInfo)")
        let aps = userInfo["aps"] as! [String: Any]
        print("\(aps)")
    }
    
}
