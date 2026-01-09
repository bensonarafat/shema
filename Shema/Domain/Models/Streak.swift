//
//  Streak.swift
//  Shema
//
//  Created by Benson Arafat on 05/01/2026.
//

import Foundation

struct Streak : Codable, Identifiable {
    let id: UUID
    let userId: String
    let date: Date
    
    enum CodingKeys: String, CodingKey {
        case id, userId, date
    }
}
