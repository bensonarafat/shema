//
//  AppNavigation+Enums.swift
//  Shema
//
//  Created by Benson Arafat on 08/01/2026.
//

import Foundation
import SwiftUI

enum AppRoute: Hashable {
    // Onboarding
    case welcome
    case onboarding
    
    // Home
    case home
    case bible
    case settings
    case bookmarks
    case bookmarkDetail(id: String)
    case tabs
    case badges
    case themeVerses
    case focus(id: String)
    case scripture(id: String)
    case editProfile
    case shemaai(BibleArg)
    case streakReward(id: String)
    case currencyReward(id: String)
    
    // Settings
    case lockSchedule
    
    // Auth
    case login
    case register
    case registerNowLater(Bool)
    case forgotPassword
    
    @ViewBuilder
    var view: some View {
        switch self  {
            // Onboarding
            case .onboarding: OnboardingView()
            case .welcome: WelcomeView()
                
            // Main Tabs
            case .bible: BibleReaderView()
            case .bookmarks: BookmarkView()
            case .home: HomeView()
            case .settings: SettingsView()
            case .tabs: BottomNavigationView()
                
            // Features
            case .badges: BadgesView()
            case .themeVerses: ThemeVersesView()
            case .focus(let id): FocusView(id: id)
            case .scripture(let id): ScriptureView(id: id)
            case .shemaai(let bibleArg): ShemaAIView(bibleArg: bibleArg)
            case .bookmarkDetail(let id): BookmarkDetailsView(id: id)
            case .editProfile: EditProfileView()
                
            // Rewards
            case .streakReward(let id): StreakRewardView(id: id)
            case .currencyReward(let id): CurrencyRewardView(id: id)
                
            // Settings
            case .lockSchedule: LockScheduleView()
                
            // Auth
            case .login: LoginView()
            case .register: RegisterView()
            case .registerNowLater(let fromOnboarding): RegisterNowLaterView(fromOnboarding: fromOnboarding)
            case .forgotPassword: ForgotPasswordView()
        }
    }
}
