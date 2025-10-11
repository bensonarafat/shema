//
//  ReadingProgress.swift
//  Shema
//
//  Created by Benson Arafat on 08/10/2025.
//

import Foundation
import Combine

class ReadingProgress: ObservableObject {
    @Published var currentReading: BibleReading?
    @Published var readingStartTime: Date?
    @Published var scrollProgress: Double = 0.0
    @Published var minimumTimeSpent: TimeInterval = 120 // 2 minutes
    
    private let userDefaults = UserDefaults.standard
    private let lastCompletionKey = "lastReadingCompletion"
    private let streakKey = "readingStreak"
    
    
    var hasCompletedTodaysReading: Bool {
        guard let lastCompletion = userDefaults.object(forKey: lastCompletionKey) as? Date else {
            return false
        }
        return Calendar.current.isDateInToday(lastCompletion)
    }
    
    
    var currentStreak: Int {
        userDefaults.integer(forKey: streakKey)
    }
    
    
    func startReading(_ reading: BibleReading) {
        currentReading = reading
        readingStartTime = Date()
        scrollProgress = 0.0
    }
    
    func updateProgress(_ progress: Double ) {
        scrollProgress = max(scrollProgress, progress)
    }
    
    func canCompleteReading() -> Bool {
        guard let startTime = readingStartTime else { return false }
        let timeSpent = Date().timeIntervalSince(startTime)
        return scrollProgress >= 0.8 && timeSpent >= minimumTimeSpent
    }
    
    func completeReading () {
        userDefaults.set(Date(), forKey: lastCompletionKey)
        updateStreak()
        reset()
    }
    
    private func updateStreak() {
        let calendar = Calendar.current
        if let lastCompletion = userDefaults.object(forKey: lastCompletionKey) as? Date {
            if calendar.isDateInYesterday(lastCompletion) {
                let currentStreak = userDefaults.integer(forKey: streakKey)
                userDefaults.set(currentStreak + 1, forKey: streakKey)
            } else if !calendar.isDateInToday(lastCompletion) {
                userDefaults.set(1, forKey: streakKey)
            }
        } else {
            userDefaults.set(1, forKey: streakKey)
        }
    }
    
    
    private func reset() {
        currentReading = nil
        readingStartTime = nil
        scrollProgress = 0.0
    }
}
