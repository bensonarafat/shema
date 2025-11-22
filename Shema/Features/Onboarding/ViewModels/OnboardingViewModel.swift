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
    
    private let onboardingKey = "hasCompletedOnboarding"
    
    init() {
        self.hasCompletedOnboarding = UserDefaults.standard.bool(forKey: onboardingKey)
    }
    
    func completeOnboarding () {
        hasCompletedOnboarding = true
        UserDefaults.standard.set(true, forKey: onboardingKey)
    }
    
    
}
