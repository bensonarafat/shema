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
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationStack (path: $nav.path){
            Group {
                
              if authViewModel.isCheckingAuth {
                   loadingView
              }  else if authViewModel.isAuthenticated || authViewModel.hasCompleteAuthStep {
                   BottomNavigationView()
               } else {
                   WelcomeView()
               }
            }
            .background(Color.theme.backgroundColor)
            .ignoresSafeArea(edges: .bottom)
            .navigationDestination(for: AppDestination.self) { destination in
                destinationView(for: destination)
            }
        }
        .task {
            await authViewModel.refreshAuthToken()
        }
        .onChange(of: authViewModel.isAuthenticated) { oldValue, newValue in
               if newValue && !oldValue {
                   nav.popToRoot()
               }
        }
    }

    private var loadingView: some View {
           ZStack {
               Color.theme.backgroundColor
                   .ignoresSafeArea()
               
               VStack(spacing: 20) {
                   ProgressView()
                       .progressViewStyle(CircularProgressViewStyle(tint: .theme.primaryColor))
                       .scaleEffect(1.5)
                   
                   Text("Loading...")
                       .font(.fontNunitoRegular(size: 16))
                       .foregroundColor(.theme.secondaryTextColor)
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
            BottomNavigationView()
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
            
        case .editProfile:
            EditProfileView()
            
        // Setttings
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

#Preview {
    let vm = OnboardingViewModel()
    let nav = NavigationManager()
    let authVM = AuthViewModel()
    ContentView()
        .environmentObject(vm)
        .environmentObject(nav)
        .environmentObject(authVM)
}

