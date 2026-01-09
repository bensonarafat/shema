//
//  ProfileViewModel.swift
//  Shema
//
//  Created by Benson Arafat on 03/01/2026.
//

import Foundation
import Combine
import FirebaseAuth

class ProfileViewModel : ObservableObject {
    @Published var currentUser: ShemaUser?
    @Published var overviews: [Overview] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var successMessage: String?
    
    private var userService: UserService
    private var authService: AuthService
    private let userDefaults = UserDefaults.standard
    private let currencyKey = "local_currency"
    private let streakKey = "local_streaks"
    
    init(userService: UserService = UserService(), authService: AuthService = AuthService()) {
        self.userService = userService
        self.authService = authService
        loadCurrentUser()
        loadOverview()
    }
    
    func loadOverview() {
        let currency = loadLocalCurrency()
        let streakCount = calculateCurrentStreak()
        overviews = [
            Overview(type: "xp", value: "\(currency.xp) XP", image: "xp"),
            Overview(type: "gem", value: "\(currency.gem)", image: "gem"),
            Overview(type: "streak", value:"\(streakCount) days", image: "streak"),
            Overview(type: "key", value: "\(currency.key) keys", image: "key"),
        ]
    }
    
    private func loadLocalCurrency() -> Currency {
         guard let data = userDefaults.data(forKey: currencyKey),
               let currency = try? JSONDecoder().decode(Currency.self, from: data) else {
             return Currency(xp: 0, gem: 0, key: 0)
         }
         return currency
     }
     
     private func loadLocalStreaks() -> [Streak] {
         guard let data = userDefaults.data(forKey: streakKey),
               let streaks = try? JSONDecoder().decode([Streak].self, from: data) else {
             return []
         }
         return streaks
     }
     
    private func calculateCurrentStreak() -> Int {
        let streaks = loadLocalStreaks()
        guard !streaks.isEmpty else { return 0 }
        
        let sortedStreaks = streaks.sorted { $0.date > $1.date }
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        var currentStreak = 0
        var checkDate = today
        
        for streak in sortedStreaks {
            let streakDate = calendar.startOfDay(for: streak.date)
            
            if calendar.isDate(streakDate, inSameDayAs: checkDate) {
                currentStreak += 1
                checkDate = calendar.date(byAdding: .day, value: -1, to: checkDate)!
            } else if streakDate < checkDate {
                // Gap found, stop counting
                break
            }
        }
        
        return currentStreak
    }
    
    
    func loadCurrentUser() {
        guard let userId = authService.currentUser?.uid else {
            errorMessage = "User not authenticated"
            return
        }
        
        Task {
            await MainActor.run { self.isLoading = true }
            
            do {
                let user = try await userService.getUser(userId: userId)

                await MainActor.run {
                    self.currentUser = user
                    self.isLoading = false
                    self.errorMessage = nil
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = "Failed to load user: \(error.localizedDescription)"
                    self.isLoading = false
                }
            }
        }
    }
    
    func updateProfile(fullName: String, username: String) async -> Bool {
        guard let userId = authService.currentUser?.uid else {
            await MainActor.run {
                self.errorMessage = "User not authenticated"
            }
            return false
        }
        
        guard let currentUser = currentUser else {
            await MainActor.run {
                self.errorMessage = "User data not loaded"
            }
            return false
        }
        
        // Validate inputs
        guard !fullName.trimmingCharacters(in: .whitespaces).isEmpty else {
            await MainActor.run {
                self.errorMessage = "Full name cannot be empty"
            }
            return false
        }
        
        guard !username.trimmingCharacters(in: .whitespaces).isEmpty else {
            await MainActor.run {
                self.errorMessage = "Username cannot be empty"
            }
            return false
        }
        
        // Validate username format
        guard username.isValidUsername else {
            await MainActor.run {
                self.errorMessage = "Username can only contain letters, numbers, and underscores"
            }
            return false
        }
        
        await MainActor.run { self.isLoading = true }
        
        do {
            // Check if username has changed and if new username is available
            if username.lowercased() != currentUser.username.lowercased() {
                let usernameExists = try await userService.checkIfUsernameExists(username: username)
                if usernameExists {
                    await MainActor.run {
                        self.errorMessage = "Username is already taken"
                        self.isLoading = false
                    }
                    return false
                }
            }
            
            // Create updated user
            var updatedUser = currentUser
            updatedUser.fullName = fullName.trimmingCharacters(in: .whitespaces)
            updatedUser.username = username.lowercased().trimmingCharacters(in: .whitespaces)
            
            // Update in Firestore
            _ = try await userService.updateUser(shemaUser: updatedUser)
            
            await MainActor.run {
                self.currentUser = updatedUser
                self.successMessage = "Profile updated successfully"
                self.errorMessage = nil
                self.isLoading = false
            }
            
            return true
            
        } catch {
            await MainActor.run {
                self.errorMessage = "Failed to update profile: \(error.localizedDescription)"
                self.isLoading = false
            }
            return false
        }
    }
    
    func checkUsernameAvailability(username: String) async -> Bool {
        guard let currentUser = currentUser else { return false }
        
        // If username hasn't changed, it's available
        if username.lowercased() == currentUser.username.lowercased() {
            return true
        }
        
        do {
            let exists = try await userService.checkIfUsernameExists(username: username)
            return !exists
        } catch {
            return false
        }
    }
    
    func clearMessages() {
        errorMessage = nil
        successMessage = nil
    }
}
