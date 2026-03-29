//
//  NotificationManager.swift
//  Shema
//
//  Created by Benson Arafat on 28/03/2026.
//

import Foundation
import Combine
import UserNotifications

class NotificationManager: ObservableObject {
    @Published var isGranted: Bool = false
    
    static let shared = NotificationManager()
    
    init() {
        checkPermission()
    }
    
    func checkPermission() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.isGranted = settings.authorizationStatus == .authorized
            }
        }
    }
    
    func requestPerimission() async {
        do {
            let granted = try await UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .badge, .sound])
            await MainActor.run {
                self.isGranted = granted
            }
        } catch {
            await MainActor.run {
                self.isGranted = false
            }
        }
    }
    
    func scheduleDailyDevotion(at hour: Int, minute: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Good morning 🙏"
        content.body = "Your daily devotion is ready."
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: true
        )
        
        let request = UNNotificationRequest(
            identifier: "daily_devotion",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
}
