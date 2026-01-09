//
//  BadgeViewModel.swift
//  Shema
//
//  Created by Benson Arafat on 03/11/2025.
//

import Foundation
import Combine
import FirebaseAuth

class BadgeViewModel : ObservableObject {
    @Published var allBadges: [Badge]  = []
    @Published var completedBadges: [Badge] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var userService: UserService
    private var authService: AuthService
    
    
    private let userDefaults = UserDefaults.standard
    private let badgeKey = "local_badge"
    
    init(userService: UserService = UserService(), authService: AuthService = AuthService()) {
        self.userService = userService
        self.authService = authService
        loadBadges()
    }
    
    func loadBadges() {
        var allAvailableBadges = Badge.all
        // fetch all completed badges stored locally and update the completed to true
        guard let data = userDefaults.data(forKey: badgeKey),
                let localCompletedBadges = try? JSONDecoder().decode([Badge].self, from: data) else {
            self.allBadges = allAvailableBadges
            self.completedBadges = []
            return
        }
        // Mark badges as completed based on local storage
        for completedBadge in localCompletedBadges {
            if let index = allAvailableBadges.firstIndex(where: { $0.id == completedBadge.id }) {
                allAvailableBadges[index].completed = true
                allAvailableBadges[index].completedAt = completedBadge.completedAt
            }
        }
        
        self.allBadges = allAvailableBadges
        self.completedBadges = allAvailableBadges.filter { $0.completed }
    }
    
    func syncBadgesWithServer () async {
        guard let userId = authService.currentUser?.uid else {
            await MainActor.run {
                self.errorMessage = "User not authenticated"
            }
            return
        }
        
        await MainActor.run { self.isLoading = true }
        defer { Task { await MainActor.run { self.isLoading = false } } }
        
        do {
            let user = try await userService.getUser(userId: userId)
            
            // If user has badges stored on server, sync them
            if let serverBadges = user.userBadges {
                await MainActor.run {
                    self.updateBadgesFromServer(serverBadges: serverBadges)
                }
            }
        } catch {
            await MainActor.run {
                self.errorMessage = "Failed to sync badges: \(error.localizedDescription)"
            }
        }
    }
    
    private func updateBadgesFromServer(serverBadges: [UserBadge]) {
        var updatedBadges = Badge.all
        
        for serverBadge in serverBadges {
            if let index = updatedBadges.firstIndex(where: { $0.name == serverBadge.name }) {
                updatedBadges[index].completed = true
                updatedBadges[index].completedAt = serverBadge.completedAt
            }
        }
        
        self.allBadges = updatedBadges
        self.completedBadges = updatedBadges.filter { $0.completed }
        saveCompletedBadgesLocally()
    }
    
    /// Mark a badge as completed
    func completeBadge(badgeId: UUID) async -> Bool {
        guard let userId = authService.currentUser?.uid else {
            await MainActor.run {
                self.errorMessage = "User not authenticated"
            }
            return false
        }
        
        guard let index = allBadges.firstIndex(where: { $0.id == badgeId }) else {
            await MainActor.run {
                self.errorMessage = "Badge not found"
            }
            return false
        }
        
        // Don't complete if already completed
        guard !allBadges[index].completed else {
            return true
        }
        
        await MainActor.run { self.isLoading = true }
        defer { Task { await MainActor.run { self.isLoading = false } } }
        
        do {
            let user = try await userService.getUser(userId: userId)
            
            // Update badge locally
            await MainActor.run {
                self.allBadges[index].completed = true
                self.allBadges[index].completedAt = Date()
                self.completedBadges = self.allBadges.filter { $0.completed }
                self.saveCompletedBadgesLocally()
            }
            
            // Update on server
            let userBadge = UserBadge(
                name: allBadges[index].name,
                completedAt: allBadges[index].completedAt ?? Date()
            )
            
            var updatedUser = user
            var userBadges = updatedUser.userBadges ?? []
            
            // Only add if not already present
            if !userBadges.contains(where: { $0.name == userBadge.name }) {
                userBadges.append(userBadge)
                updatedUser.userBadges = userBadges
                
                _ = try await userService.updateUser(shemaUser: updatedUser)
            }
            
            await MainActor.run {
                self.errorMessage = nil
            }
            
            return true
            
        } catch {
            // Revert local change on error
            await MainActor.run {
                self.allBadges[index].completed = false
                self.allBadges[index].completedAt = nil
                self.completedBadges = self.allBadges.filter { $0.completed }
                self.errorMessage = "Failed to complete badge: \(error.localizedDescription)"
            }
            return false
        }
    }
    
    /// Get top 9 badges (completed first, then sorted by some criteria)
     func topNineBadges() -> [Badge] {
         let sorted = allBadges.sorted { lhs, rhs in
             // Completed badges first
             if lhs.completed != rhs.completed {
                 return lhs.completed
             }
             // Then by completion date (most recent first)
             if let lhsDate = lhs.completedAt, let rhsDate = rhs.completedAt {
                 return lhsDate > rhsDate
             }
             // Then alphabetically
             return lhs.name < rhs.name
         }
         return Array(sorted.prefix(9))
     }
    
    /// Get all completed badges
    func getCompletedBadges() -> [Badge] {
        return completedBadges
    }
    
    /// Get all uncompleted badges
   func getUncompletedBadges() -> [Badge] {
       return allBadges.filter { !$0.completed }
   }
    
    /// Get completion percentage
    func completionPercentage() -> Double {
        guard !allBadges.isEmpty else { return 0 }
        return Double(completedBadges.count) / Double(allBadges.count) * 100
    }
    
    /// Check if a specific badge is completed
      func isBadgeCompleted(badgeId: UUID) -> Bool {
          return allBadges.first(where: { $0.id == badgeId })?.completed ?? false
      }
    
    private func saveCompletedBadgesLocally() {
          let completed = allBadges.filter { $0.completed }
          guard let data = try? JSONEncoder().encode(completed) else {
              return
          }
          userDefaults.set(data, forKey: badgeKey)
    }
    
    /// Clear all badge data (useful for logout)
    func clearBadgeData() {
        allBadges = Badge.all.map { badge in
            var b = badge
            b.completed = false
            b.completedAt = nil
            return b
        }
        completedBadges = []
        userDefaults.removeObject(forKey: badgeKey)
    }
    
    /// Force refresh from server
    func refreshBadges() async {
        await syncBadgesWithServer()
    }
}
