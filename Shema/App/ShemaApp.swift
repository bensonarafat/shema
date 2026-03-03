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
    @StateObject private var networkMonitor = NetworkMonitor.shared
    @StateObject private var streakViewModel = StreakViewModel()
    @StateObject private var currencyViewModel = CurrencyViewModel()
    @StateObject private var badgeViewModel = BadgeViewModel()
    @StateObject private var scriptureService = ScriptureService()
    @StateObject private var bookmarkViewModel = BookmarkViewModel()
    
    @Environment(\.scenePhase) private var scenePhase
    
    let backgroundTaskIdentifier = "com.pulsereality.shema.refresh"
    
    init () {
        NavigationBarStyle.apply()
        AppCheck.setAppCheckProviderFactory(AppCheckDebugProviderFactory())
        FirebaseApp.configure()
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
                .environmentObject(networkMonitor)
                .environmentObject(streakViewModel)
                .environmentObject(currencyViewModel)
                .environmentObject(badgeViewModel)
                .environmentObject(scriptureService)
                .environmentObject(bookmarkViewModel)
                .onReceive(NotificationCenter.default.publisher(for: SettingsViewModel.rescheduleBackgroundTasksNotification)) { _ in
                    scheduleAppRefresh()
                }
                .onAppear {
                    // Schedule daily notification
                    familyControlViewModel.scheduleDailyBlockingCheck()
                    // check blocking status on launch
                    familyControlViewModel.updateAppBlockingStatus()
                }
        }
        .onChange(of: scenePhase) { oldPhase, newPhase in
            
            switch newPhase {
            case .background:
                scheduleAppRefresh()
            case .active:
                familyControlViewModel.resetForNewDay()
                // Clear notification badge
                Task {
                    try await UNUserNotificationCenter.current().setBadgeCount(0)
                }
            case .inactive:
                print("App become inactive")
            @unknown default:
                break
            }
            
        }
    }
    
    func registerBackgroundTasks() {
        
        BGTaskScheduler.shared.register(
            forTaskWithIdentifier: backgroundTaskIdentifier, using: nil
        ) { task in
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
    }
    
    func handleAppRefresh(task: BGAppRefreshTask) {
        // Schedule the next refresh
        scheduleAppRefresh()
        
        task.expirationHandler = {
            task.setTaskCompleted(success: false)
        }
        
        performBackgroundWork { success in
            task.setTaskCompleted(success: success)
        }
    }
    
    func scheduleAppRefresh() {
        // Cancel existing task
        BGTaskScheduler.shared.cancel(taskRequestWithIdentifier: backgroundTaskIdentifier)
        
        let request = BGAppRefreshTaskRequest(identifier: backgroundTaskIdentifier)
        
        // Get User's lcok time or default to 4AM
        let (hour, minute) = familyControlViewModel.getLockTime()
        
        // Calculate next occurence of lock time
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: Date())
        components.hour = hour
        components.minute = minute
        
        guard var scheduleDate = calendar.date(from: components) else {
            print("Failed to create scheduled date")
            return
        }
        
        if scheduleDate <= Date() {
            scheduleDate = calendar.date(byAdding: .day, value: 1, to: scheduleDate) ?? scheduleDate
        }
        
        request.earliestBeginDate = scheduleDate
        
        do {
            try BGTaskScheduler.shared.submit(request)
            print("Background task scheduled for: \(scheduleDate)")
        } catch {
            print("Could not schedule app refresh: \(error)")
        }
    }
    
    
    func performBackgroundWork(completion: @escaping (Bool) -> Void) {
        print("Performing background work...")
       // Check and update app blocking status
       familyControlViewModel.updateAppBlockingStatus()
       
       // Simulate async work completion
       DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
           completion(true)
       }
    }
    

}
