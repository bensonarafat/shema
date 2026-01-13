//
//  SettingsViewModel.swift
//  Shema
//
//  Created by Benson Arafat on 06/01/2026.
//

import Foundation
import Combine
import FirebaseAuth

class SettingsViewModel : ObservableObject {
    @Published var pushNotification: Bool = true
    @Published var selectedReadTime: String?
    @Published var defaultBook: String?
    @Published var customTime: Date = Date()
    private var userService: UserService
    private var authService: AuthService
    private let networkMonitor = NetworkMonitor.shared
    
    private let pushNotificationKey = "local_push_notification"
    private let readTimeKey = "readTime"
    private let defaultBookKey = "defaultBook"
    private let customTimeKey = "customTime"
    
    private let userDefaults = UserDefaults.standard
    private var authStateHandle: AuthStateDidChangeListenerHandle?
    
    init(userService: UserService = UserService(), authService: AuthService = AuthService()) {
        self.userService = userService
        self.authService = authService
        self.pushNotification = userDefaults.bool(forKey: pushNotificationKey)
        self.selectedReadTime = userDefaults.string(forKey: readTimeKey)
        self.defaultBook = userDefaults.string(forKey: defaultBookKey)
        if let savedCustomTime = userDefaults.object(forKey: customTimeKey) as? Date {
            self.customTime = savedCustomTime
        }
        
        // Listen for auth state changes
        setupAuthStateListener()
    }
    
    deinit {
        if let handle = authStateHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    private func setupAuthStateListener() {
        authStateHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self, let user = user else { return }
            Task {
                await self.syncRemoteDataLocally(userId: user.uid)
            }
        }
    }
    
    private func syncRemoteDataLocally(userId: String) async {
        do {
            let shemaUser = try await userService.getUser(userId: userId)
            userDefaults.set(shemaUser.pushNotification, forKey: pushNotificationKey)
            await MainActor.run {
                self.pushNotification = shemaUser.pushNotification
            }
        } catch {
            print("Failed to sync notifications \(error)")
        }
    }
    
    
    @MainActor
    func updateNotificationSettings(_ val: Bool) async {
        guard checkNetwork() else { return }
        guard let userId = authService.currentUser?.uid else {
            return
        }
        
        do {
            let user = try await userService.getUser(userId: userId)
            
            var updatedUser = user
            updatedUser.pushNotification = val;
            _ = try await userService.updateUser(shemaUser: updatedUser)
            userDefaults.set(val, forKey: pushNotificationKey)
        } catch {
            print("Failed to fetch user: \(error)")
        }
    }
    
    @MainActor
    func setReadTime (time: String) async {
        guard checkNetwork() else { return }
        selectedReadTime = time
        guard let userId = authService.currentUser?.uid else {
            return
        }
        do {
            let user = try await userService.getUser(userId: userId)
            var updatedUser = user
            updatedUser.lockTime = time
            _ = try await userService.updateUser(shemaUser: updatedUser)
            userDefaults.set(time, forKey: readTimeKey)
            if selectedReadTime == "Custom" {
                userDefaults.set(customTime, forKey: customTimeKey)
            }
        } catch {
            print("Failed to fetch user: \(error)")
        }
    }
    
    
  @MainActor
    func setBibleBook (book: String) async {
        guard checkNetwork() else { return }
        guard let userId = authService.currentUser?.uid else {
            return
        }
        do {
            let user = try await userService.getUser(userId: userId)
            var updatedUser = user
            updatedUser.defaultBook = book
            _ = try await userService.updateUser(shemaUser: updatedUser)
            userDefaults.set(book, forKey: defaultBookKey)
        } catch {
            print("Failed to fetch user: \(error)")
        }
    }
    
   func checkNetwork() -> Bool {
        guard networkMonitor.isConnected else {
            return false
        }
       return true
    }
}
