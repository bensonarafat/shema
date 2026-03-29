//
//  OnboardingViewModel.swift
//  Shema
//
//  Created by Benson Arafat on 21/11/2025.
//

import Foundation
import Combine
import FamilyControls

class OnboardingViewModel: ObservableObject {
    @Published var currentStep: Int = 0
    
    // Goals
    @Published var selectedGoal: String? = nil
    let goals = [
        "Grow closer to God",
        "Build a consistent prayer habit",
        "Study the Bible deeper",
        "Find peace and encouragement",
        "Overcome a specific struggle"
    ]
    
    // Focus
    @Published var selectedFocus: String? = nil
    let focusAreas = [
        "Faith & Trust",
        "Relationships",
        "Purpose & Identity",
        "Anxiety & Fear",
        "Gratitude",
        "Healing"
    ]
    
    // Translation
    @Published var selectedTranslation: String? = "NIV"
    let translations = ["NIV", "ESV", "KJV", "NLT"]
    
    // Time
    @Published var devotionTime: Date = Calendar.current.date(
        bySettingHour: 7, minute: 0, second: 0, of: Date()
    ) ?? Date()
    
    // Family Controls - no longer owned here, just a reference
    private let familyControlManager: FamilyControlManager
    private var cancellables = Set<AnyCancellable>()
    
    @Published var requestLoading: Bool = false
    @Published var loading: Bool = false
    
    let totalSteps: Int = 5
    
    init(familyControlManager: FamilyControlManager = FamilyControlManager.shared) {
        self.familyControlManager = familyControlManager
        familyControlManager.$isAuthorized
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
    
    var canContinue: Bool {
          switch currentStep {
          case 0: return selectedGoal != nil
          case 1: return selectedFocus != nil
          case 2: return selectedTranslation != nil
          case 4: return isAuthorized != false
          default: return true
          }
      }
      
    var isAuthorized: Bool {
          familyControlManager.isAuthorized
      }
    
    var activitySelection: FamilyActivitySelection {
          get { familyControlManager.activitySelection }
          set { familyControlManager.activitySelection = newValue }
      }
    
    func requestFamilyControls() async {
        requestLoading = true
        await familyControlManager.requestAuthorization()
        requestLoading = false
     }
    
    func previous() {
        currentStep -= 1
    }
    
    func next(router: AppRouter, authManager: AuthManager) async {
        if currentStep < totalSteps - 1 {
            currentStep += 1
        } else {
            loading = true
            await finish(router: router, authManager: authManager)
            loading = false
        }
    }
 
    func skipFamilyControls() {
         currentStep += 1
     }
    
    private func finish(router: AppRouter, authManager: AuthManager) async {
        // Save family controls selection
        familyControlManager.saveSelection()

        
        // Schedule notification at preferred time
        scheduleNotification()
        
        // Save preferences to UserDefaults
        savePreferences()
        
        // Mark onboarding complete and go to pricing
        await authManager.completeOnboarding()
        authManager.appState = .pricing
    }
    
    private func scheduleNotification() {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: devotionTime)
        let minute = calendar.component(.minute, from: devotionTime)
        NotificationManager.shared.scheduleDailyDevotion(at: hour, minute: minute)
    }
    
    
    private func savePreferences() {
         let defaults = UserDefaults.standard
         defaults.set(selectedGoal, forKey: "onboarding_goals")
         defaults.set(selectedFocus, forKey: "onboarding_focus")
         defaults.set(selectedTranslation, forKey: "onboarding_translation")
         defaults.set(devotionTime, forKey: "onboarding_devotion_time")
     }
}
