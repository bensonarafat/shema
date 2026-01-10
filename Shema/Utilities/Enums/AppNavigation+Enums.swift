//
//  AppNavigation+Enums.swift
//  Shema
//
//  Created by Benson Arafat on 08/01/2026.
//

import Foundation

enum AppDestination {
    
    // Onboarding
    case welcome
    case onboarding
    
    // Home
    case home
    case bible
    case settings
    case bookmarks
    case bookmarkDetail(Bookmark)
    case tabs
    case badges
    case themeVerses
    case focus(Focus)
    case scripture(DailyScripture)
    case editProfile
    case shemaai(BibleArg)
    case streakReward
    case currencyReward
    
    // Settings
    case lockSchedule
    
    // Auth
    case login
    case register
    case registerNowLater
    case forgotPassword
}

extension AppDestination: Equatable {
    static func == (lhs: AppDestination, rhs: AppDestination) -> Bool {
        switch (lhs, rhs) {
        case (.welcome, .welcome),
             (.onboarding, .onboarding),
             (.home, .home),
             (.bible, .bible),
             (.settings, .settings),
             (.bookmarks, .bookmarks),
             (.tabs, .tabs),
             (.badges, .badges),
             (.themeVerses, .themeVerses),
             (.scripture, .scripture),
             (.editProfile, .editProfile),
             (.lockSchedule, .lockSchedule),
             (.login, .login),
             (.register, .register),
             (.registerNowLater, .registerNowLater),
             (.forgotPassword, .forgotPassword):
            return true
        case (.focus, .focus):
            // Consider all focus destinations equal regardless of associated value
            return true
        case (.shemaai, .shemaai):
            // Consider all shemaai destinations equal regardless of associated value
            return true
        case (.bookmarkDetail, .bookmarkDetail):
            return true
        default:
            return false
        }
    }
}

extension AppDestination: Hashable {
    func hash(into hasher: inout Hasher) {
        switch self {
        case .welcome: hasher.combine(0)
        case .onboarding: hasher.combine(1)
        case .home: hasher.combine(2)
        case .bible: hasher.combine(3)
        case .settings: hasher.combine(4)
        case .bookmarks: hasher.combine(5)
        case .tabs: hasher.combine(6)
        case .badges: hasher.combine(7)
        case .themeVerses: hasher.combine(8)
        case .focus: hasher.combine(9)
        case .scripture: hasher.combine(10)
        case .editProfile: hasher.combine(11)
        case .shemaai: hasher.combine(12)
        case .lockSchedule: hasher.combine(13)
        case .login: hasher.combine(14)
        case .register: hasher.combine(15)
        case .registerNowLater: hasher.combine(16)
        case .forgotPassword: hasher.combine(17)
        case .currencyReward: hasher.combine(18)
        case .streakReward: hasher.combine(19)
        case .bookmarkDetail: hasher.combine(20)
        }
    }
}
