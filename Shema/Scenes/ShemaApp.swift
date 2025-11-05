//
//  ShemaApp.swift
//  Shema
//
//  Created by Benson Arafat on 07/10/2025.
//

import SwiftUI
import SwiftData
import BackgroundTasks

@main
struct ShemaApp: App {
    @StateObject private var viewModel = BibleLockViewModel()
    @StateObject private var navigationManager = NavigationManager()
    
    init () {
        registerBackgroundTasks()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .environmentObject(navigationManager)
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
        viewModel.resetDaily()
        
        task.setTaskCompleted(success: true)
    }
}
