//
//  RootView.swift
//  Shema
//
//  Created by Benson Arafat on 24/03/2026.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        Group {
            switch authManager.appState {
            case .welcome:
                WelcomeView()
            case .onboarding:
                OnboardingView()
                
            case .auth:
                NavigationStack  {
                    AppRoute.login.destination
                        .navigationDestination(for: AppRoute.self) { route in
                            route.destination
                        }
                }
            case .main:
                MainTabView()
            }
        }

    }
}

#Preview {
    RootView()
        .environmentObject(AuthManager())
        .environmentObject(AppRouter())
}
