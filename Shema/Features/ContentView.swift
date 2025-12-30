//
//  ContentView.swift
//  Shema
//
//  Created by Benson Arafat on 07/10/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var onboardingViewModel: OnboardingViewModel
    @EnvironmentObject var nav: NavigationManager
    
    var body: some View {
        NavigationStack (path: $nav.path){
            Group {
                if !onboardingViewModel.hasCompletedOnboarding {
                    WelcomeView()
                } else {
                    TabBarView()
                }
            }
            .background(Color.theme.backgroundColor).ignoresSafeArea()
            .navigationDestination(for: AppDestination.self) { destination in
                destinationView(for: destination)
            }
        }
    }

    
    @ViewBuilder
    private func destinationView (for destination: AppDestination) -> some View {
        switch destination {
        // onboarding
        case .onboarding:
            OnboardingView()
        case .welcome:
            WelcomeView()
        case .bible:
            BibleReaderView()
        case .bookmarks:
            BookmarkView()
        case .home:
            HomeView()
        case .settings:
            SettingsView()
        case .tabs:
            TabBarView()
        case .badges:
            BadgesView(viewModel: BadgeViewModel())
        case .themeVerses:
            ThemeVersesView()
        case .focus(let focus):
            FocusView(focus: focus)
            
        // Auth
        case .login:
            LoginView()
        case .register:
            RegisterView()
        }
    }
}

#Preview {
    let vm = OnboardingViewModel()
    let nav = NavigationManager()
    ContentView()
        .environmentObject(vm)
        .environmentObject(nav)
}
