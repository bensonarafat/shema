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
    
    private let store = ManagedSettingsStore()
    private let authCenter = AuthorizationCenter.shared
    
    @Published var  isAuthorized: Bool = false
    @Published var blockedApps: Set<ApplicationToken> = []
    
    private let blockedAppsKey = "blockedApplicationTokens"
    
    init () {
        loadBlockedApps()
        checkAuthorizationStatus()
    }
    
    // Request Family Controls authorization
    func requestAuthorization() async throws {
        do {
            try await authCenter.requestAuthorization(for: FamilyControlsMember.individual)
            await MainActor.run {
                self.isAuthorized = true
            }
        } catch {
            await MainActor.run {
                self.isAuthorized = false
            }
            throw error
        }
    }
    
    func checkAuthorizationStatus() {
        switch authCenter.authorizationStatus {
        case .denied:
            isAuthorized = false
        case .approved:
            isAuthorized = true
        default:
            isAuthorized = false
        }
    }
    
    // Save selected apps to block
    func saveBlockedApps(_ apps: FamilyActivitySelection) {
        blockedApps = apps.applicationTokens
        
        // Save to UserDaults (token persist across app launches)
        if let encoded = try? JSONEncoder().encode(apps.applicationTokens) {
            UserDefaults.standard.set(encoded, forKey: blockedAppsKey)
        }
    }
    
    // Load previously selected apps
    private func loadBlockedApps() {
        if let data = UserDefaults.standard.data(forKey: blockedAppsKey),
           let decoded = try? JSONDecoder().decode(Set<ApplicationToken>.self, from: data) {
            blockedApps = decoded
        }
    }
    
    // Enable app blocking (morning/when reading not complete)
    func enableBlocking () {
        guard !blockedApps.isEmpty else { return }
        
        store.shield.applications = blockedApps
        
//   ->     store.shield.applicationCategories= .specific(Set([utilitiesCategoryToken]))
        
        print("App blocked: \(blockedApps.count) apps")
    }
    
    // Disable app blocking (after completin Bible reading)
    func disableBlocking() {
        store.shield.applications = nil
        store.shield.applicationCategories = nil
        
        print("App unblocked")
    }
    
    // Check if blocking should be active
    func updateBlockingStatus(readingComplete: Bool) {
        if readingComplete {
            disableBlocking()
        } else {
            enableBlocking()
        }
    }
}
