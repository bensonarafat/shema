//
//  NotificationService.swift
//  Shema
//
//  Created by Benson Arafat on 08/10/2025.
//

import Foundation
import UserNotifications

class NotificationService {
    static let shared = NotificationService()
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound, .provisional]) { granted, error in
            if granted {
                print("Notification permission granted")
            } else if let error = error {
                print("Notification error: \(error.localizedDescription)")
            }
        }
    }
    
    
    func scheduleReadingReminder(at hour: Int, minute: Int = 0) {
        let content = UNMutableNotificationContent()
        content.title = "Time for Bible Reading"
        content.body = "Complete your daily reading to unlock your app"
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "dailyReminder", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
    
    
    func sendImmediateReminder() {
        let content = UNMutableNotificationContent()
        content.title = "Apps Are Locked"
        content.body = "Complete your Bible reading to unlock"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}
