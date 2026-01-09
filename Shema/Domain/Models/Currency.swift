//
//  Currency.swift
//  Shema
//
//  Created by Benson Arafat on 03/01/2026.
//

import Foundation

struct Currency: Codable {
    var xp: Int;
    var gem: Int;
    var key: Int;

}

enum CurrencyType : String, CaseIterable {
  case xp
  case gem
  case key
}

struct Overview : Hashable {
    let type: String
    let value: String
    let image: String
}
