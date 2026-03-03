//
//  FamilyControlViewModel.swift
//  Shema
//
//  Created by Benson Arafat on 21/11/2025.
//
import UIKit

import Foundation
import Combine

class FamilyControlViewModel: ObservableObject {
    
    @Published var showingAppPicker = false
    
    var appBlockingService = AppBlockingService.shared
    let bibleService = BibleService.shared
    let notificationService = NotificationService.shared
    private let userDefaults = UserDefaults.standard
    private let readTimeKey = "readTime"
    private let customTimeKey = "customTime"
    private let lastBlockingDateKey = "lastBlockingDate"
    
    
    /// Main function to check and update app blocking status
    /// Call this from background refresh and when app becomes active
    func updateAppBlockingStatus() {
        let shouldBlock = shouldBlockApps()
        let hasReadToday = appBlockingService.hasCompletedReadingToday()
        
        if shouldBlock && !hasReadToday {
            // Block apps and send notification
            appBlockingService.enableBlocking()
            sendUnlockNotification()
            print("🔒 Apps blocked - Bible reading not completed")
        } else if hasReadToday {
            // Unblock apps if reading is complete
            appBlockingService.disableBlocking()
            print("✅ Apps unlocked - Bible reading completed")
        }
        
        // Save the last check date
        userDefaults.set(Date(), forKey: lastBlockingDateKey)
    }
    
    /// Determines if apps should be blocked based on current time and user settings
      private func shouldBlockApps() -> Bool {
          let now = Date()
          let calendar = Calendar.current
          let currentHour = calendar.component(.hour, from: now)
          let currentMinute = calendar.component(.minute, from: now)
          
          // Get user's preferred lock time or use default (4 AM)
          let (lockHour, lockMinute) = getLockTime()
          
          // Check if current time is past the lock time
          if currentHour > lockHour {
              return true
          } else if currentHour == lockHour && currentMinute >= lockMinute {
              return true
          }
          
          return false
      }
    
    /// Gets the lock time from user settings or returns default (4 AM)
    func getLockTime() -> (hour: Int, minute: Int) {
        guard let readTime = userDefaults.string(forKey: readTimeKey) else {
            return (4, 0) // Default: 4 AM
        }
        switch readTime {
        case "4:00 AM":
            return (4, 0)
        case "5:00 AM":
            return (5, 0)
        case "6:00 AM":
            return (6, 0)
        case "7:00 PM":
            return (19, 0)
        case "8:00 PM":
            return (20, 0)
        default:
            return (4, 0) // Default: 4 AM
        }
    }
    
    /// Sends a notification to remind user to read the Bible
    private func sendUnlockNotification() {
        let content = UNMutableNotificationContent()
        content.title = "📖 Time to Read Your Bible"
        content.body = "Complete your daily Bible reading to unlock your apps"
        content.sound = .default
        content.badge = 1
        
        // Send immediately
        let request = UNNotificationRequest(
            identifier: "bible-unlock-reminder",
            content: content,
            trigger: nil // nil trigger means send immediately
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Failed to send notification: \(error)")
            } else {
                print("✅ Unlock reminder notification sent")
            }
        }
    }
    
    /// Schedule daily check at the user's preferred time
    func scheduleDailyBlockingCheck() {
        // Cancel existing notifications
        UNUserNotificationCenter.current().removePendingNotificationRequests(
            withIdentifiers: ["daily-blocking-check"]
        )
        
        let (hour, minute) = getLockTime()
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: true
        )
        
        let content = UNMutableNotificationContent()
        content.title = "📖 Daily Bible Reading"
        content.body = "Time for your daily Bible reading!"
        content.sound = .default
        
        let request = UNNotificationRequest(
            identifier: "daily-blocking-check",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Failed to schedule daily notification: \(error)")
            } else {
                print("✅ Daily blocking check scheduled for \(hour):\(String(format: "%02d", minute))")
            }
        }
    }
    
    /// Check if it's a new day since last blocking check
    func isNewDay() -> Bool {
        guard let lastCheck = userDefaults.object(forKey: lastBlockingDateKey) as? Date else {
            return true // First time, treat as new day
        }
        
        let calendar = Calendar.current
        return !calendar.isDate(lastCheck, inSameDayAs: Date())
    }
    
    /// Reset blocking status for new day
    func resetForNewDay() {
        if isNewDay() {
            updateAppBlockingStatus()
        }
    }
}
