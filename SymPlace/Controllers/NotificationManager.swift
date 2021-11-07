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

    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        let lat = UserDefaults.standard.double(forKey: "notificationLat")
        let long = UserDefaults.standard.double(forKey: "notificationLong")
        if lat != 0 && long != 0 {
            print("OPENING NOTIFICATION FOR THE OPENER THING")
            InformationManager.shared.presentReviewForCoords(lat: lat, long: long, isUpdate: false)
        }
    }
    
    public func sendLocalNotification(title: String, body: String, location: Location? = nil) {
        let notification = UNMutableNotificationContent()
        
        notification.title = title
        notification.body = body
        
        
        if location != nil {
            UserDefaults.standard.set(location!.lat, forKey: "notificationLat")
            UserDefaults.standard.set(location!.long, forKey: "notificationLong")
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5,
                                                            repeats: false)
        let request = UNNotificationRequest(identifier: "locationSuggestion",
                                            content: notification,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            print("SENDING NOTIFICATION GAVE")
            print("ERROR: \(error.debugDescription)")
        }
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
