//
//  AuthViewModel.swift
//  Shema
//
//  Created by Benson Arafat on 31/12/2025.
//

import Foundation
import Combine
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var hasCompleteAuthStep: Bool
    @Published var isAuthenticated: Bool = false
//    @Published var authSuccess: Bool = false
    @Published var currentUser: User?
    @Published var shemaUser: ShemaUser?
    @Published var isLoading: Bool = false
    @Published var errorMessage: AuthErrorMessage?
    
    private let authService: AuthService
    private let userService: UserService
    private let streakService: StreakService
    private let completeAuthStepKey = "hasCompleteAuthStep"
    private let userDataKey = "local_user"
    
    private let userDefaults = UserDefaults.standard
    private let networkMonitor = NetworkMonitor.shared
    
    init(authService: AuthService = AuthService(),
         userService: UserService = UserService(),
         streakService: StreakService = StreakService(),
    ) {
        self.hasCompleteAuthStep = userDefaults.bool(forKey: completeAuthStepKey)
        self.authService = authService
        self.userService = userService
        self.streakService = streakService
        fetchUserLocalData()
    }
    
    func completeAuthStep() {
        userDefaults.set(true, forKey: completeAuthStepKey)
    }
    
    private func syncRemoteDataLocally(_ user: ShemaUser) async {
        if let data = try? JSONEncoder().encode(user) {
            userDefaults.set(data, forKey: userDataKey)
        }
    
    }
    
    private func fetchUserLocalData () {
        guard let data = userDefaults.data(forKey: userDataKey) else {
            self.isAuthenticated = false
            return
        }
        if let cached = try? JSONDecoder().decode(ShemaUser.self, from: data) {
            self.shemaUser = cached
        }
        self.isAuthenticated = true
    }
    
    
    
    func signUp(email: String, password: String, fullName: String, confirmPassword: String) async {
        guard checkNetwork() else {
            errorMessage = AuthErrorMessage(message: "Please check your internet connection")
            isLoading = false
            return
        }
        
        isLoading = true
        errorMessage = nil
        do {
            guard !fullName.isEmpty else {
                errorMessage = AuthErrorMessage( message: "Please enter your full name")
                isLoading = false
                return
            }
            guard password == confirmPassword else {
                errorMessage = AuthErrorMessage(message: "Password must match")
                isLoading = false
                return
            }
            let user = try await authService.signUpUser(email: email, password: password)
            // extract username from email address
            let username = email.usernameFromEmail
            let shemaUser: ShemaUser = try await userService.createUser(shemaUser: ShemaUser(id: user.uid, fullName: fullName, username: username, email: email))
            await syncRemoteDataLocally(shemaUser)
            await MainActor.run {
                self.isAuthenticated = true
            }

        } catch let error as AuthError {
            errorMessage = AuthErrorMessage(message:error.errorDescription ?? "Oops! an error occurred" )
        } catch {
            errorMessage = AuthErrorMessage(message: "An unexpected error occurred")
        }
        
        isLoading = false
    }
    
    func refreshAuthToken() async {
        guard checkNetwork() else { return }
        
        guard let user = authService.currentUser else {
            await MainActor.run {
                self.isAuthenticated = false
                self.currentUser = nil
            }
            
            return
        }
        
        do {
            let _ = try await user.getIDTokenResult(forcingRefresh: true)
            await MainActor.run {
                self.isAuthenticated = true
                self.currentUser = user
            }
        } catch {
            await MainActor.run {
                self.logout()
            }
        }
    }
    
    func signIn(email: String, password: String) async {
        guard checkNetwork() else {
            errorMessage = AuthErrorMessage(message: "Please check your internet connection")
            isLoading = false
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let user = try await authService.sigInUser(email: email, password: password)
            let shemaUser = try await userService.getUser(userId: user.uid)
            await syncRemoteDataLocally(shemaUser)
            await MainActor.run {
                self.isAuthenticated = true
            }

        } catch let error as AuthError {
            errorMessage = AuthErrorMessage(message:error.errorDescription ?? "Oops! an error occurred" )
        } catch {
            errorMessage = AuthErrorMessage(message: "An unexpected error occurred")
        }
        isLoading = false
    }
    
    func signInWithGoogle() async {
        guard checkNetwork() else {
            errorMessage = AuthErrorMessage(message: "Please check your internet connection")
            isLoading = false
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let user = try await authService.signInWithGoogle()
            let username = user.email!.usernameFromEmail
            let shemaUser = try await userService.createUser(shemaUser: ShemaUser(id: user.uid, fullName: user.displayName ?? "Unknown user", username: username, email: user.email!))
            await syncRemoteDataLocally(shemaUser)
            await MainActor.run {
                self.isAuthenticated = true
            }
        }catch let error as AuthError {
            errorMessage = AuthErrorMessage(message:error.errorDescription ?? "Oops! an error occurred" )
        } catch {
            errorMessage = AuthErrorMessage(message: "Google sign-in failed")
        }
        
        isLoading = false
    }
    
    func signInWithApple() async {
        guard checkNetwork() else {
            errorMessage = AuthErrorMessage(message: "Please check your internet connection")
            isLoading = false
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let user = try await authService.signInwithApple()
            let username = user.email!.usernameFromEmail
            let shemaUser = try await userService.createUser(shemaUser: ShemaUser(id: user.uid,  fullName: user.displayName ?? "Unknown user", username: username, email: user.email!))
            await syncRemoteDataLocally(shemaUser)
            await MainActor.run {
                self.isAuthenticated = true
            }
        } catch let error as AuthError {
            errorMessage = AuthErrorMessage(message:error.errorDescription ?? "Oops! an error occurred" )
        } catch {
            errorMessage = AuthErrorMessage(message: "Apple sign-in failed")
        }
        isLoading = false
    }
    
    func logout () {
        do {
            try authService.logout()
            currentUser = nil
            isAuthenticated = false
            errorMessage = nil
            clearUserDefaults()
        } catch {
            errorMessage = AuthErrorMessage(message: "Failed to sign out")
        }
    }
    
    func deleteAccount () async -> Bool {
        guard checkNetwork() else {
            errorMessage = AuthErrorMessage(message: "Please check your internet connection")
            isLoading = false
            return false
        }
        isLoading = true
        errorMessage = nil
        do {
            guard let userId = authService.currentUser?.uid else { return false }
            _ =  try await userService.deleteUser(userId: userId)
            try await streakService.deleteStreaks(userId: userId)
            try await authService.deleteAccount()
            clearUserDefaults()
            isLoading = false
            return true
        } catch {
            errorMessage = AuthErrorMessage(message: "Failed to delete account")
            isLoading = false
            return false
        }
    }
    
    func resetPassword (email: String) async -> Bool {
        guard checkNetwork() else {
            errorMessage = AuthErrorMessage(message: "Please check your internet connection")
            isLoading = false
            return false
        }
        isLoading = true
        errorMessage = nil
        do {
            try await authService.resetPassword(email: email)
            isLoading = false
            return true
        } catch let error as AuthError {
            errorMessage = AuthErrorMessage(message:error.errorDescription ?? "Oops! an error occurred" )
            isLoading = false
            return false
        } catch {
            errorMessage = AuthErrorMessage(message: "Failed to send password reset email")
            isLoading = false
            return false
        }
    }
    
    func clearError () {
        errorMessage = nil
    }
    
    func checkNetwork() ->  Bool {
        guard networkMonitor.isConnected else {
            return false
        }
        return true
    }
    
    func clearUserDefaults() {
        guard let bundleID = Bundle.main.bundleIdentifier else { return }
        userDefaults.removePersistentDomain(forName: bundleID)
    }
}
