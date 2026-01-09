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
    var defaultBook: String?
    
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
         defaultBook: String? = nil,) {
        self.id = id
        self.fullName = fullName
        self.username = username
        self.email = email
        self.createdAt = createdAt
        self.lastLogin = lastLogin
        self.pushNotification = pushNotification
        self.lockTime = lockTime
        self.defaultBook = defaultBook
    }
    
    static func == (lhs: ShemaUser, rhs: ShemaUser) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
