//
//  AuthManager.swift
//  Shema
//
//  Created by Benson Arafat on 24/03/2026.
//

import Foundation
import Combine
import FirebaseAuth

enum AppState {
    case welcome
    case onboarding
    case pricing
    case auth
    case main
}

class AuthManager: ObservableObject {
    @Published var appState: AppState = .welcome
    @Published var currentFirebaseUser: User? = nil
    @Published var currentUser: ShemaUser? = nil
    
    private let authService: AuthService
    private let userService: UserService
    private let userDefaults = UserDefaults.standard
    private let userDataKey = "local_user"
    private let _onboarding: String = "hasCompleteOnboarding"
    
    init (
        authService: AuthService = AuthService(),
        userSevice: UserService = UserService()
    ) {
        self.authService = authService
        self.userService = userSevice
        checkSession()
    }
    
    private func checkSession() {
        if  let data = userDefaults.data(forKey: userDataKey), let user = try? JSONDecoder().decode(ShemaUser.self, from: data) {
            self.currentUser = user
            if !user.completeOnboarding {
                self.appState = .onboarding
            } else {
                self.appState = .main
            }
      
        } else {
            self.appState = .welcome
        }
    }
    
    
    func completeOnboarding() async {
        
        userDefaults.set(true, forKey: _onboarding)
        // update the user data to complete onboarding
        guard var shemaUser = currentUser else { return }
        let updatedUser = shemaUser.copyWith(completeOnboarding: true)
        self.currentUser = updatedUser
        do {
            let _ = try await userService.updateUser(shemaUser: updatedUser);
            if let data = try? JSONEncoder().encode(updatedUser) {
                userDefaults.set(data, forKey: userDataKey)
            }
        } catch {
            print("Failed to update user after onboarding: \(error)")
        }
   

    }

    
    func handleSignInSuccess(firebaseUser: User, fullName: String, email: String) async throws {
        // check if exist
        if let shemaUser = try? await userService.getUser(userId: firebaseUser.uid) {
            await cacheAndLogin(shemaUser)
        }else {
            let username = email.usernameFromEmail
            let shemaUser = try await userService.createUser(shemaUser: ShemaUser(id: firebaseUser.uid, fullName: fullName, username: username, email: email) )
            await cacheAndLogin(shemaUser)
        }
    }
    
    func logout() {
        try? authService.logout()
        currentUser = nil
        clearCache()
        appState = .auth
    }
    
    private func cacheAndLogin(_ user: ShemaUser) async {
        if let data = try? JSONEncoder().encode(user) {
            userDefaults.set(data, forKey: userDataKey)
        }
        await MainActor.run {
            self.currentUser = user
            if user.completeOnboarding {
                self.appState = .main
            } else {
                self.appState =  .onboarding
            }

        }
    }
    
    private func clearCache() {
        guard let bundleID = Bundle.main.bundleIdentifier else { return }
        userDefaults.removePersistentDomain(forName: bundleID)
    }
    
    var auth: AuthService { authService }
    var users: UserService { userService }
}
