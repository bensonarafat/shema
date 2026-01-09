//
//  Common+Enums.swift
//  Shema
//
//  Created by Benson Arafat on 08/10/2025.
//

import Foundation

enum Tabs: Int {
    case home = 0
    case bible = 1
    case achievements = 2
    case bookmark = 3
    case settings = 4
    case profile = 5
}

enum BibleAPIError: Error, LocalizedError {
    case invalidURL, networkError(Error), decodingError(Error), noData, fileError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .networkError(let e): return "Network error: \(e.localizedDescription)"
        case .decodingError(let e): return "Decoding error: \(e.localizedDescription)"
        case .noData: return "No data received"
        case .fileError(let e): return "File error: \(e.localizedDescription)"
        }
    }
}


enum AuthError: LocalizedError {
    case invalidEmail
    case weakPassword
    case userNotFound
    case wrongPassword
    case emailAlreadyInUse
    case networkError
    case googleSignInFailed
    case appleSignInFailed
    case requiresRecentLogin
    case unknownError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return "Please enter a valid email address."
        case .weakPassword:
            return "Password must be at least 6 characters long."
        case .userNotFound:
            return "No account found with this email."
        case .wrongPassword:
            return "Incorrect password. Please try again."
        case .emailAlreadyInUse:
            return "An account with this email already exists."
        case .networkError:
            return "Network error. Please check your connection."
        case .googleSignInFailed:
            return "Google sign-in failed. Please try again."
        case .appleSignInFailed:
            return "Apple sign-in failed. Please try again."
        case .requiresRecentLogin:
            return "Required to log in again. Please try signing in again."
        case .unknownError(let message):
            return message 
        }
    }
}

enum UserServiceError: LocalizedError {
    case userNotFound
    case emailAlreadyExists
    case invalidData
    case deletionFailed
    case unknownError(String)
    
    var errorDescription: String? {
        switch self {
        case .userNotFound:
            return "User not found."
        case .emailAlreadyExists:
            return "A user with this email already exists."
        case .invalidData:
            return "Invalid user data."
        case .deletionFailed:
            return "Failed to delete user."
        case .unknownError(let message):
            return message
        }
    }
}


enum StreakError: LocalizedError {
    case notAuthenticated
    case syncFailed
    
    var errorDescription: String? {
        switch self {
        case .notAuthenticated:
            return "User is not authenticated"
        case .syncFailed:
            return "Failed to sync with server"
        }
    }
}

enum CurrencyError: LocalizedError {
    case userNotAuthenticated
    case insufficientBalance
    case updateFailed
    
    var errorDescription: String? {
        switch self {
        case .userNotAuthenticated:
            return "User is not authenticated"
        case .insufficientBalance:
            return "Insufficient balance"
        case .updateFailed:
            return "Failed to update currency"
        }
    }
}


enum BadgeError: LocalizedError {
    case userNotAuthenticated
    case badgeNotFound
    case updateFailed
    
    var errorDescription: String? {
        switch self {
        case .userNotAuthenticated:
            return "User is not authenticated"
        case .badgeNotFound:
            return "Badge not found"
        case .updateFailed:
            return "Failed to update badge"
        }
    }
}

