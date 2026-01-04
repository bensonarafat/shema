//
//  Currency.swift
//  Shema
//
//  Created by Benson Arafat on 03/01/2026.
//

import Foundation

enum Currency : String, CaseIterable {
  case xp
  case gem
  case key
  case leaf
  case streak
  case level
}

struct Overview : Hashable {
    let currency: Currency
    let value: String
    let image: String
}


extension Overview {
    static let all : [Overview] = [
        Overview(currency: .xp, value: "500 XP", image: "xp"),
        Overview(currency: .level, value: "Gold", image: "xp"),
        Overview(currency: .streak, value: "100 days", image: "streak"),
        Overview(currency: .gem, value: "200", image: "gem"),
        Overview(currency: .key, value: "5 keys", image: "gem"),
        Overview(currency: .leaf, value: "5 leafs", image: "gem"),
    ]
}
