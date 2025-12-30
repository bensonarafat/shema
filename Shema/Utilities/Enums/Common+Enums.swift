//
//  Common+Enums.swift
//  Shema
//
//  Created by Benson Arafat on 08/10/2025.
//

import Foundation


enum AppDestination: Hashable {
    
    // Onboarding
    case welcome
    case onboarding
    
    // Home
    case home
    case bible
    case settings
    case bookmarks
    case tabs
    case badges
    case themeVerses
    case focus(Focus)
    
    // Auth
    case login
    case register
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
