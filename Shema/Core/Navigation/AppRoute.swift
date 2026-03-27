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
    
    // auth
    case login
    case register
    case forgotPassword
    
    // main tab
    case home
    case bible
    case more
    case settings
    
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .welcome: WelcomeView()
        case .onboarding: OnboardingView()
        
        case .login:    LoginView()
        case .register: RegisterView()
        case .forgotPassword: ForgotPasswordView()
            
        case .home: HomeView()
        case .bible: BibleView()
        case .more: MoreView()
        case .settings: SettingsView()
            
        }
    }
    
}
