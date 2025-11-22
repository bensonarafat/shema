//
//  BadgeViewModel.swift
//  Shema
//
//  Created by Benson Arafat on 03/11/2025.
//

import Foundation
import Combine

class BadgeViewModel : ObservableObject {
    @Published var allBadges: [Badge]  = []
    @Published var unlockedBadges: Set<UUID> = []
    
    init() {
        loadBadges()
    }
    
    func loadBadges() {
        self.allBadges = Badge.all
    }
    
    func topSixBadges()  -> [Badge]{
        let sorted = allBadges.sorted { $0.completed && $1.completed}
        return Array(sorted.prefix(6))
    }
    
    func unlock (_ badge: Badge) {
        unlockedBadges.insert(badge.id)
    }
    
    func isUnlocked (_ badge: Badge) -> Bool {
        return unlockedBadges.contains(badge.id)
    }
    
    var progress: Double {
        guard !allBadges.isEmpty else { return 0}
        return Double(unlockedBadges.count) / Double(allBadges.count)
    }
    
}
