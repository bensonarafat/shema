//
//  OnboardingViewModel.swift
//  Shema
//
//  Created by Benson Arafat on 21/11/2025.
//

import Foundation
import Combine

class OnboardingViewModel: ObservableObject {
    
    @Published var hasCompletedOnboarding: Bool
    @Published var selectedReadTime: String?
    
    private let onboardingKey = "hasCompletedOnboarding"
    private let readTimeKey = "readTime"
    
    private let userDefaults = UserDefaults.standard;
    
    init() {
        self.hasCompletedOnboarding = userDefaults.bool(forKey: onboardingKey)
        self.selectedReadTime = userDefaults.string(forKey: readTimeKey)
    }
    
    func completeOnboarding () {
        hasCompletedOnboarding = true
        userDefaults.set(true, forKey: onboardingKey)
    }
    
    func setReadTime (time: String) {
        selectedReadTime = time
        userDefaults.set(time, forKey: readTimeKey)
    }
    
    func getReadTime() -> String? {
        return userDefaults.string(forKey: readTimeKey)
    }
    
    func resetOnboarding () {
        hasCompletedOnboarding = false
        selectedReadTime = nil
        userDefaults.removeObject(forKey: onboardingKey)
        userDefaults.removeObject(forKey: readTimeKey)
    }
    
}
