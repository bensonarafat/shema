//
//  ShemaUser.swift
//  Shema
//
//  Created by Benson Arafat on 01/01/2026.
//

import Foundation

struct ShemaUser: Codable, Identifiable, Hashable {
    let id: String
    var fullName: String
    var username: String
    let email: String
    let createdAt: Date
    let lastLogin: Date
    var pushNotification: Bool
    var lockTime: String?
    var completeOnboarding: Bool
    var goal: String?
    var focus: String?
    var translation: String?
    var devotionTime: Date? 
    
    var currency: Currency?
    
    var userBadges: [UserBadge]?
    
    init(id: String,
         fullName: String,
         username: String,
         email: String,
         createdAt: Date = Date(),
         lastLogin: Date = Date(),
         pushNotification: Bool = true,
         lockTime: String? = nil,
         completeOnboarding: Bool = false,
         goal: String? = nil,
         focus: String? = nil,
         translation: String? = nil,
         devotionTime: Date? = nil,
    ) {
        self.id = id
        self.fullName = fullName
        self.username = username
        self.email = email
        self.createdAt = createdAt
        self.lastLogin = lastLogin
        self.pushNotification = pushNotification
        self.lockTime = lockTime
        self.completeOnboarding = completeOnboarding
        self.goal = goal
        self.focus = focus
        self.translation = translation
        self.devotionTime = devotionTime
    }
    
    static func == (lhs: ShemaUser, rhs: ShemaUser) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func copyWith(
        fullName: String? = nil,
        username: String? = nil,
        pushNotification: Bool? = nil,
        lockTime: String?? = nil,
        completeOnboarding: Bool? = nil,
        goal: String?? = nil,
        focus: String?? = nil,
        translation: String?? = nil,
        devotionTime: Date?? = nil,
        currency: Currency?? = nil,
        userBadges: [UserBadge]?? = nil
    ) -> ShemaUser {
        var copy = self
        if let fullName             { copy.fullName = fullName }
        if let username             { copy.username = username }
        if let pushNotification     { copy.pushNotification = pushNotification }
        if let lockTime             { copy.lockTime = lockTime }
        if let completeOnboarding   { copy.completeOnboarding = completeOnboarding }
        if let goal                 { copy.goal = goal }
        if let focus                { copy.focus = focus }
        if let translation          { copy.translation = translation }
        if let devotionTime         { copy.devotionTime = devotionTime }
        if let currency             { copy.currency = currency }
        if let userBadges           { copy.userBadges = userBadges }
        return copy
    }
}
