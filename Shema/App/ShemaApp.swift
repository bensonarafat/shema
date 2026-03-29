//
//  ShemaApp.swift
//  Shema
//
//  Created by Benson Arafat on 07/10/2025.
//

import SwiftUI
import SwiftData
import BackgroundTasks
import FirebaseCore

@main
struct ShemaApp: App {
    @StateObject private var approuter = AppRouter()
    @StateObject private var authManager = AuthManager()
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var notificationManager = NotificationManager()
    @StateObject private var familyControlManager = FamilyControlManager()
    @StateObject private var onboardingViewModel = OnboardingViewModel()
    @StateObject private var storekitManager = StoreKitManager()
    
    @Environment(\.scenePhase) private var scenePhase
    
    let backgroundTaskIdentifier = "com.pulsereality.shema.refresh"
    
    init () {
        FirebaseApp.configure()
        let manager = AuthManager()
        _authManager = StateObject(wrappedValue: manager)
        _authViewModel = StateObject(wrappedValue: AuthViewModel(authManager: manager))
        _approuter = StateObject(wrappedValue: AppRouter())
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(approuter)
                .environmentObject(authManager)
                .environmentObject(authViewModel)
                .environmentObject(notificationManager)
                .environmentObject(familyControlManager)
                .environmentObject(onboardingViewModel)
                .environmentObject(storekitManager)
        }

    }

    

}
