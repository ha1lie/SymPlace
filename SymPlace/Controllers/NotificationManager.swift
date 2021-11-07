//
//  NotificationManager.swift
//  SymPlace
//
//  Created by Hallie on 11/6/21.
//

import Foundation
import UIKit
import UserNotifications


class NotificationManager: NSObject, UNUserNotificationCenterDelegate, ObservableObject {
    static let shared: NotificationManager = NotificationManager()
    
    private let defaults = UserDefaults.standard
    
    @Published var enabled: Bool = false
    
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
        self.enabled = true
        if !defaults.bool(forKey: self.defaultsRegisterSuccess) {
            //Has never gotten/registered the device ID
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { success, error in
                self.defaults.set(success, forKey: self.defaultsRegisterSuccess)
                if success {
                    DispatchQueue.main.sync {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
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
