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
                NavigationStack (path: $router.onboardingPath) {
                    AppRoute.introduction.destination
                        .navigationDestination(for: AppRoute.self) { route  in
                            route.destination
                        }
                }
            case .pricing:
                NavigationStack (path: $router.pricingPath) {
                    AppRoute.pricing.destination
                        .navigationDestination(for: AppRoute.self) { route in
                            route.destination
                        }
                }
            case .auth:
                NavigationStack(path: $router.authPath)  {
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
