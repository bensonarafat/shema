//
//  AppBlockingService.swift
//  Shema
//
//  Created by Benson Arafat on 09/10/2025.
//

import Foundation
import FamilyControls
import ManagedSettings
import DeviceActivity
import Combine

class AppBlockingService: ObservableObject{
    static let shared = AppBlockingService()
    
    @Published var  isAuthorized: Bool = false
    @Published var blockedApps: Set<ApplicationToken> = []
    @Published var blockedCategories: Set<ActivityCategoryToken> = []
    
    private let store = ManagedSettingsStore()
    private let center = AuthorizationCenter.shared
    private let selectionKey = "savedFamilyActivitySelection"
    
    init () {
        isAuthorized = center.authorizationStatus == .approved
        // Load saved selection on init
        if let savedSelection = loadBlockedApps() {
            blockedApps = savedSelection.applicationTokens
            blockedCategories = savedSelection.categoryTokens
        }
    }
    
    func requestAuthorization() async throws {
        try await center.requestAuthorization(for: .individual)
        await MainActor.run {
            isAuthorized = center.authorizationStatus == .approved
        }
    }
    
    
    // Save selected apps to block
    func saveBlockedApps(_ selection: FamilyActivitySelection) {
        blockedApps = selection.applicationTokens
        blockedCategories = selection.categoryTokens
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(selection)
            UserDefaults.standard.set(data, forKey: selectionKey)
            print("Selection saved successfully")
        }catch {
            print("Failed to save selection: \(error)")
        }
    }

    func loadBlockedApps () -> FamilyActivitySelection? {
        guard let data = UserDefaults.standard.data(forKey: selectionKey) else {
            print("No saved selection found")
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            let selection = try decoder.decode(FamilyActivitySelection.self, from: data)
            print("Selection loaded successfully")
            return selection
        } catch {
            print("Failed to load selection: \(error)")
            return nil
        }
    }
    
    func updateBlockingStatus(readingComplete: Bool) {
        if readingComplete {
            disableBlocking()
        } else {
            enableBlocking()
        }
    }
    
    // Enable app blocking (morning/when reading not complete)
    func enableBlocking () {
        guard !blockedApps.isEmpty || !blockedCategories.isEmpty  else {
            print("No apps or categories to block")
            return
        }
        
        store.shield.applications = blockedApps.isEmpty ? nil : blockedApps
        
        if !blockedCategories.isEmpty {
            store.shield.applicationCategories = .specific(blockedCategories)
        }
        
        print("Blocking enabled for \(blockedApps.count) apps and \(blockedCategories.count) categories")
    }
    
    // Disable app blocking (after completin Bible reading)
    func disableBlocking() {
        store.shield.applications = nil
        store.shield.applicationCategories = nil
        print("App unblocked")
    }
    
    
    func clearAllBlocking() {
        store.clearAllSettings()
        blockedApps.removeAll()
        blockedCategories.removeAll()
        UserDefaults.standard.removeObject(forKey: selectionKey)
        print("All blocking settings cleared")
    }
}

