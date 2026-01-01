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
    @Published var authSuccess: Bool = false
    @Published var currentUser: User?
    @Published var isCheckingAuth: Bool = true
    @Published var isLoading: Bool = false
    @Published var errorMessage: AuthErrorMessage?
    
    private let authService: AuthService
    private let userService: UserService
    private var authStateHandle: AuthStateDidChangeListenerHandle?
    private let completeAuthStepKey = "hasCompleteAuthStep"
    
    private let userDefaults = UserDefaults.standard
    
    init(authService: AuthService = AuthService(), userService: UserService = UserService()) {
        self.hasCompleteAuthStep = userDefaults.bool(forKey: completeAuthStepKey)
        self.authService = authService
        self.userService = userService
        setupAuthStateListener()
    }
    
    deinit {
        if let handle = authStateHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    func completeAuthStep() {
        hasCompleteAuthStep = true
        userDefaults.set(true, forKey: completeAuthStepKey)
    }
    
    private func setupAuthStateListener() {
        authStateHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            Task { @MainActor in
                self?.currentUser = user
                self?.isAuthenticated = user != nil
                self?.isCheckingAuth = false
            }
        }
    }
    
    func signUp(email: String, password: String, fullName: String, confirmPassword: String) async {
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
            _ = try await userService.createUser(shemaUser: ShemaUser(id: user.uid, fullName: fullName, email: email))
            Task { @MainActor in
                self.authSuccess = true
            }

        } catch let error as AuthError {
            errorMessage = AuthErrorMessage(message:error.errorDescription ?? "Oops! an error occurred" )
        } catch {
            errorMessage = AuthErrorMessage(message: "An unexpected error occurred")
        }
        
        isLoading = false
    }
    
    func refreshAuthToken() async {
        guard let user = authService.currentUser else {
            await MainActor.run {
                self.isAuthenticated = false
                self.currentUser = nil
            }
            
            return
        }
        
        do {
            let result = try await user.getIDTokenResult(forcingRefresh: true)
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
        isLoading = true
        errorMessage = nil
        
        do {
            let _ = try await authService.sigInUser(email: email, password: password)
            Task { @MainActor in
                self.authSuccess = true
            }

        } catch let error as AuthError {
            errorMessage = AuthErrorMessage(message:error.errorDescription ?? "Oops! an error occurred" )
        } catch {
            errorMessage = AuthErrorMessage(message: "An unexpected error occurred")
        }
        isLoading = false
    }
    
    func signInWithGoogle() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let user = try await authService.signInWithGoogle()
            _ = try await userService.createUser(shemaUser: ShemaUser(id: user.uid, fullName: user.displayName ?? "Unknown user", email: user.email!))
            Task { @MainActor in
                self.authSuccess = true
            }
        }catch let error as AuthError {
            errorMessage = AuthErrorMessage(message:error.errorDescription ?? "Oops! an error occurred" )
        } catch {
            errorMessage = AuthErrorMessage(message: "Google sign-in failed")
        }
        
        isLoading = false
    }
    
    func signInWithApple() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let user = try await authService.signInwithApple()
            _ = try await userService.createUser(shemaUser: ShemaUser(id: user.uid,  fullName: user.displayName ?? "Unknown user", email: user.email!))
            Task { @MainActor in
                self.authSuccess = true
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
        } catch {
            errorMessage = AuthErrorMessage(message: "Failed to sign out")
        }
    }
    
    func resetPassword (email: String) async -> Bool {
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
}
