//
//  BibleLockViewModel.swift
//  Shema
//
//  Created by Benson Arafat on 10/10/2025.
//

import Foundation
import Combine

class BibleLockViewModel: ObservableObject {
    @Published var hasCompletedOnboarding: Bool
    @Published var readingProgress = ReadingProgress()
    @Published var currentReading: BibleReading?
    @Published var showingAppPicker = false
    
    var appBlockingService = AppBlockingService.shared
    let bibleService = BibleAPIService.shared
    let notificationService = NotificationService.shared
    
    private let onboardingKey = "hasCompletedOnboarding"
    
    init () {
        self.hasCompletedOnboarding = UserDefaults.standard.bool(forKey: onboardingKey)
        loadTodaysReading()
        updateAppBlockingStatus()
    }
    
    func completeOnboarding() {
        hasCompletedOnboarding = true
        UserDefaults.standard.set(true, forKey: onboardingKey)
    }
    
    func loadTodaysReading() {
        currentReading = bibleService.getTodayReading()
    }
    
    func startReading () {
        guard let reading = currentReading else { return }
        readingProgress.startReading(reading)
    }
    
    func completeReading () {
        readingProgress.completeReading()
        appBlockingService.disableBlocking()
    }
    
    func updateAppBlockingStatus() {
        let isComplete = readingProgress.hasCompletedTodaysReading
        appBlockingService.updateBlockingStatus(readingComplete: isComplete)
        
        if !isComplete {
            notificationService.sendImmediateReminder()
        }
    }
    
    func resetDaily() {
        // Call this at midnight
        if !Calendar.current.isDateInToday(Date()) {
            loadTodaysReading()
            updateAppBlockingStatus()
        }
    }
}
