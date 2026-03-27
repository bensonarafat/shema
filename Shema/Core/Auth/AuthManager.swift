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
    case auth
    case main
}

class AuthManager: ObservableObject {
    @Published var appState: AppState = .welcome
    @Published var currentFirebaseUser: User? = nil
    @Published var currentUser: ShemaUser? = nil
    
    private let _onboarding: String = "hasCompleteOnboarding"
    
    private let authService: AuthService
    private let userService: UserService
    
    init (
        authService: AuthService = AuthService(),
        userSevice: UserService = UserService()
    ) {
        self.authService = authService
        self.userService = userSevice
        checkSession()
    }
    
    private func checkSession() {
        
    }
    
    func login (user: User) {
        appState = .main
    }
    
    func logout() {
        appState = .auth
    }
    
    func completeOnboarding() {
        UserDefaults.standard.set(true, forKey: _onboarding)
        appState = .auth
    }
    
    func signInWithGoogle() async throws {
        do {
            let user = try await authService.signInWithGoogle()
            let username = user.email!.usernameFromEmail
            let shemaUser = try await userService.createUser(shemaUser: ShemaUser(id: user.uid, fullName: user.displayName ?? "Unknown user", username: username, email: user.email!) )
        }
    }
    
}
