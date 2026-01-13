//
//  AppDestinationFactory.swift
//  Shema
//
//  Created by Benson Arafat on 13/01/2026.
//

import SwiftUI

struct AppDestinationFactory {
    @ViewBuilder
    static func view(for destination: AppDestination) -> some View {
        switch destination {
        // Onboarding
        case .onboarding:
            OnboardingView()
        case .welcome:
            WelcomeView()
            
        // Main Tabs
        case .bible:
            BibleReaderView()
        case .bookmarks:
            BookmarkView()
        case .home:
            HomeView()
        case .settings:
            SettingsView()
        case .tabs:
            BottomNavigationView()
            
        // Features
        case .badges:
            BadgesView()
        case .themeVerses:
            ThemeVersesView()
        case .focus(let focus):
            FocusView(focus: focus)
        case .scripture(let scripture):
            ScriptureView(scripture: scripture)
        case .shemaai(let bibleArg):
            ShemaAIView(bibleArg: bibleArg)
        case .bookmarkDetail(let bookmark):
            BookmarkDetailsView(bookmark: bookmark)
        case .editProfile(let viewModel):
            EditProfileView(viewModel: viewModel)
            
        // Rewards
        case .streakReward:
            StreakRewardView()
        case .currencyReward:
            CurrencyRewardView()
            
        // Settings
        case .lockSchedule:
            LockScheduleView()
            
        // Auth
        case .login:
            LoginView()
        case .register:
            RegisterView()
        case .registerNowLater:
            RegisterNowLaterView()
        case .forgotPassword:
            ForgotPasswordView()
        }
    }
}
