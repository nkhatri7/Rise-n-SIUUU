//
//  NotificationController.swift
//  Rise-n-SIUUU
//
//  Created by Neil Khatri on 13/2/22.
//

import Foundation
import UserNotifications

class NotificationController {
    func createNotification(hour: Int, minute: Int, sound: String) {
        let content = UNMutableNotificationContent()
        content.title = "Rise n' SIUUU"
        content.subtitle = "SIUUUUUUUU"
        content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: sound))

        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.hour = hour
        dateComponents.minute = minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }
    
    func removeNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
