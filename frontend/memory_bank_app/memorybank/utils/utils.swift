//
//  utils.swift
//  creko
//
//  Created by Vohra, Ajay on 10/20/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import Foundation
import NotificationCenter

func randomString(length: Int) -> String {
  let letters = "abcdefghijklmnopqrstuvwxyz0123456789"
  return String((0..<length).map{ _ in letters.randomElement()! })
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

class S3UploadCredentials: NSObject {
    var bucket: String
    var key: String
    var credential: String
    var date: String
    var algorithm: String
    var policy: String
    var signature: String

    init(key: String, policy: String, algorithm: String,credential: String, date: String, signature: String, bucket: String) {
        self.bucket = bucket
        self.key = key
        self.credential = credential
        self.algorithm = algorithm
        self.date = date
        self.policy = policy
        self.signature = signature
    }
}

@available(iOS 10.0, *)
func userNotificationCenter(_ center: UNUserNotificationCenter,
                            willPresent notification: UNNotification,
                            withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.alert, .sound])

}

@available(iOS 10.0, *)
func showLocalNotification() {
    
    let notificationCenter = UNUserNotificationCenter.current()


    let title: String = "Photo Submitted"
    let body: String = "Sent to family for indentification"

    // construct notification content
    let content = UNMutableNotificationContent()
    content.title = NSString.localizedUserNotificationString(forKey: title, arguments: nil)
    content.body = NSString.localizedUserNotificationString(forKey: body, arguments: nil)

    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

    //getting the notification request
    let request = UNNotificationRequest(identifier: "SimplifiedIOSNotification", content: content, trigger: trigger)

    //adding the notification to notification center
    notificationCenter.add(request, withCompletionHandler: nil)
}
