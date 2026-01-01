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
import FirebaseAppCheck


@main
struct ShemaApp: App {
    @StateObject private var onboardingViewModel = OnboardingViewModel()
    @StateObject private var familyControlViewModel = FamilyControlViewModel()
    @StateObject private var bibleViewModel = BibleViewModel()
    @StateObject private var navigationManager = NavigationManager()
    @StateObject private var authViewModel = AuthViewModel()
    
    init () {
        
        #if DEBUG
        
        // Debug provider for simulator/testing
        let providerFactory = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
        #else
        // DeviceCheck provider for production (physical device only)
        let providerFactory = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
        
        #endif
        
        FirebaseApp.configure()
        
//        for familyName in UIFont.familyNames {
//            print(familyName)
//            
//            for fontName in UIFont.fontNames(forFamilyName: familyName) {
//                print("-- \(fontName)")
//            }
//        }
        registerBackgroundTasks()
        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(onboardingViewModel)
                .environmentObject(familyControlViewModel)
                .environmentObject(bibleViewModel)
                .environmentObject(navigationManager)
                .environmentObject(authViewModel)
                .onAppear {
                    scheduleAppRefresh()
                }
        }
    }
    
    func registerBackgroundTasks() {
        BGTaskScheduler.shared.register(
            forTaskWithIdentifier: "com.pulsereality.shema.refresh", using: nil
        ) { task in
            handleAppRefresh(task: task as! BGAppRefreshTask)
        }
    }
    
    func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: "com.pulsereality.shema.refresh")
        request.earliestBeginDate = Calendar.current.startOfDay(for: Date().addingTimeInterval(86400))
        
        do {
            try BGTaskScheduler.shared.submit(request)
            print("Background task scheduled")
        } catch {
            print("Cound not schedule app refresh: \(error)")
        }
    }
    
    func handleAppRefresh(task: BGAppRefreshTask) {
        scheduleAppRefresh()
        
        task.expirationHandler = {
            task.setTaskCompleted(success: false)
        }
        // Reset daily readily status at midnight
        bibleViewModel.resetDaily()
        
        task.setTaskCompleted(success: true)
    }
}
