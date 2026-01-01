//
//  ShemaUser.swift
//  Shema
//
//  Created by Benson Arafat on 01/01/2026.
//

import Foundation

struct ShemaUser : Codable, Identifiable, Hashable {
    let id: String
    let fullName: String
    let email: String
    let createdAt: Date
    let lastLogin: Date
    
    init(id: String, fullName: String, email: String, createdAt: Date = Date(), lastLogin: Date = Date() ) {
        self.id = id
        self.fullName = fullName
        self.email = email
        self.createdAt = createdAt
        self.lastLogin = lastLogin
    }
}

