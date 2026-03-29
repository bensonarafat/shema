//
//  FamilyControlManager.swift
//  Shema
//
//  Created by Benson Arafat on 28/03/2026.
//

import Foundation
import Combine
import FamilyControls
import ManagedSettings
import DeviceActivity

class FamilyControlManager: ObservableObject {
    static let shared = FamilyControlManager()
    
    @Published var isAuthorized: Bool = false
    @Published var activitySelection = FamilyActivitySelection()
    
    private let store = ManagedSettingsStore()
    private let userDefaults = UserDefaults.standard
    private let selectionKey = "family_activity_selection"
    private var cancellables = Set<AnyCancellable>()
    
    init () {

        AuthorizationCenter.shared.$authorizationStatus
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                self?.isAuthorized = status == .approved
            }
            .store(in: &cancellables)
        loadSavedSelection()
    }
    
    
    func requestAuthorization () async {
        do {
            try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
            await MainActor.run {
                self.isAuthorized = true
            }
        } catch {
            await MainActor.run {
                self.isAuthorized = false
            }
        }
    }
    
    func blockSelectedApps() {
        guard isAuthorized else { return }
        store.shield.applications = activitySelection.applicationTokens.isEmpty ? nil : activitySelection.applicationTokens
        store.shield.applicationCategories = activitySelection.categoryTokens.isEmpty ? nil : ShieldSettings.ActivityCategoryPolicy.specific(activitySelection.categoryTokens)
    }
    
    func unblockAllApps() {
        store.shield.applications = nil
        store.shield.applicationCategories = nil
    }
    
    func saveSelection() {
        if let encoded = try? JSONEncoder().encode(activitySelection) {
            userDefaults.set(encoded, forKey: selectionKey)
        }
    }
    
    private func loadSavedSelection() {
        guard let data = userDefaults.data(forKey: selectionKey),
              let decoded = try? JSONDecoder().decode(FamilyActivitySelection.self, from: data) else { return }
        self.activitySelection = decoded
    }
}
