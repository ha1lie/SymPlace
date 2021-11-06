//
//  NotificationManager.swift
//  SymPlace
//
//  Created by Hallie on 11/6/21.
//

import Foundation
import UIKit
import UserNotifications


class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    static let shared: NotificationManager = NotificationManager()
    
    private let defaults = UserDefaults.standard
    
    private let defaultsRegisterSuccess: String = "successfullyGotToken"

    
    func getToken() {
        
    }
    
    public func launchSetup() {
        print("NOTIFICATION MANAGER LAUNCH SETUP RUNNING")
        
        if !defaults.bool(forKey: self.defaultsRegisterSuccess) {
            //Has never gotten/registered the device ID
            print("NEED TO REGISTER THIS DEVICE FOR PUSH NOTIFICATIONS")

            
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { success, error in
                print("SUCCESSFULLY REGISTERED: \(success)")
                self.defaults.set(success, forKey: self.defaultsRegisterSuccess)
                if success {
                    DispatchQueue.main.sync {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                } else {
                    print("NEED TO INFORM USER THEY NEED NOTIFICATIONS ENABLED")
                }
            }
        }
        
        UNUserNotificationCenter.current().delegate = self
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print(notification.request.content.body)
        completionHandler([.alert, .sound])
    }
}
