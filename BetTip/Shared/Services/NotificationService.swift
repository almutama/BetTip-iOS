//
//  NotificationService.swift
//  BetTip
//
//  Created by Haydar Karkin on 19.05.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import Foundation
import FirebaseMessaging
import UserNotifications

extension AppDelegate {
    func setupNotification(application: UIApplication) {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            
            // For iOS 10 data message (sent via FCM)
            Messaging.messaging().delegate = self
            
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().setAPNSToken(deviceToken, type: .unknown)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    // Receive displayed notifications for iOS 10 devices.
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        // Print message ID.
        print("Message ID: \(String(describing: userInfo["gcm.message_id"]))")
        
        // Print full message.
        print("%@", userInfo)
    }
}

extension AppDelegate: MessagingDelegate {
    
    public func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        connectToMessaging()
    }
    
    // Receive data message on iOS 10 devices.
    func application(received remoteMessage: MessagingRemoteMessage) {
        print("%@", remoteMessage.appData)
    }
    
    func connectToMessaging() {
        Messaging.messaging().shouldEstablishDirectChannel = true
    }
}
