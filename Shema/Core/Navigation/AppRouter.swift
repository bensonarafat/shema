//
//  NavigationManager.swift
//  Shema
//
//  Created by Benson Arafat on 04/11/2025.
//

import Foundation
import Combine
import SwiftUI

class AppRouter : ObservableObject {
    @Published var homePath = NavigationPath()
    @Published var biblePath = NavigationPath()
    @Published var settingsPath = NavigationPath()
    @Published var morePath = NavigationPath()
    
    @Published var onboardingPath = NavigationPath()
    @Published var authPath = NavigationPath()
    @Published var pricingPath = NavigationPath()
    
    @Published var activeTab: AppTabs = .home
    
    func push<T: Hashable>(_ value: T) {
        switch activeTab {
        case .home: homePath.append(value)
        case .bible: biblePath.append(value)
        case .settings: settingsPath.append(value)
        case .more: morePath.append(value)
        }
    }
    
    func pushOnboarding<T: Hashable>(_ value: T) {
        onboardingPath.append(value)
    }
    
    func pushAuth<T: Hashable> (_ value: T) {
        authPath.append(value)
    }
    
    func pushPricing<T: Hashable> (_ value: T) {
        pricingPath.append(value)
    }
    
    func pop() {
        switch activeTab {
        case .home: if !homePath.isEmpty { homePath.removeLast() }
        case .bible: if !biblePath.isEmpty { biblePath.removeLast() }
        case .settings: if !settingsPath.isEmpty { settingsPath.removeLast() }
        case .more: if !morePath.isEmpty { morePath.removeLast() }
        }
    }
    
    func popToRoot (tab: AppTabs) {
        switch tab {
        case .home: homePath = NavigationPath()
        case .bible: biblePath = NavigationPath()
        case .settings: settingsPath = NavigationPath()
        case .more: morePath = NavigationPath()
        }
    }
    
}
