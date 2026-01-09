//
//  StreakViewModel.swift
//  Shema
//
//  Created by Benson Arafat on 05/01/2026.
//

import Foundation
import Combine
import FirebaseAuth


class StreakViewModel: ObservableObject {
    @Published var streaks: [Streak] = []
    @Published var isSyncing = false
    
    private let streakService: StreakService
    private let authService: AuthService
    
    private let userDefaults = UserDefaults.standard
    private let streakKey = "local_streaks"
    
    init(streakService: StreakService = StreakService(),
         authService: AuthService = AuthService() ) {
        self.streakService = streakService
        self.authService = authService
        self.streaks = loadLocalStreaks()
    }
    
    func loadLocalStreaks() -> [Streak] {
        guard let data = userDefaults.data(forKey: streakKey),
              let streaks = try? JSONDecoder().decode([Streak].self, from: data) else {
            return []
        }
        return streaks
    }
    
    
    func markTodayCompleted() async throws {
        guard let userId = authService.currentUser?.uid else {
            throw StreakError.notAuthenticated
        }
        
        let today = Calendar.current.startOfDay(for: Date())
        var streaks = loadLocalStreaks()
        
        // Check if already complete today
        if streaks.contains(where: { Calendar.current.isDate($0.date, inSameDayAs: today) }) {
            return
        }
        
        let newStreak = Streak(id: UUID(), userId: userId, date: today)
        streaks.append(newStreak)
        
        // Save locally
        saveLocalStreaks(streaks)
        
        // Sync to Firebase
        try await streakService.syncToFirebase(newStreak)
        
    }
    
    private func saveLocalStreaks(_ streaks: [Streak]) {
        guard let data = try? JSONEncoder().encode(streaks) else {
            return
        }
        userDefaults.set(data, forKey: streakKey)
    }
    
    
    func syncFromFirebase () async throws {
        guard let userId = authService.currentUser?.uid else {
            throw StreakError.notAuthenticated
        }
        
        DispatchQueue.main.async {
            self.isSyncing = true
        }
        
        let remoteStreaks = try await streakService.getStreaks(userId: userId)
        
        // merge with local data (remote take precedence)
        var localStreaks = loadLocalStreaks()
        let localIds = Set(localStreaks.map { $0.id })
        
        // Add remote streaks that aren't local
        for remoteStreak in remoteStreaks {
            if !localIds.contains(remoteStreak.id) {
                localStreaks.append(remoteStreak)
            }
        }
        
        // Upload local streaks that aren't remote
        let remoteIds = Set(remoteStreaks.map { $0.id })
        for localStreak in localStreaks {
            if !remoteIds.contains(localStreak.id) {
                try await streakService.syncToFirebase(localStreak)
            }
        }
        
        saveLocalStreaks(localStreaks)
        
        DispatchQueue.main.async {
            self.isSyncing = false
        }
    }
    
    func deleteAllStreaks() async throws {
        guard let userId = authService.currentUser?.uid else {
            throw StreakError.notAuthenticated
        }
        
        // Delete from firebase
        try await streakService.deleteStreaks(userId: userId)
        
        // Delete locally
        userDefaults.removeObject(forKey: streakKey)
    }
}

