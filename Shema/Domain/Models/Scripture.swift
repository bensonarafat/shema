//
//  Scripture.swift
//  Shema
//
//  Created by Benson Arafat on 08/01/2026.
//

import Foundation

struct DailyScripture : Codable, Identifiable, Hashable  {
    var id: String { date }
    let actionStep: String
    let date: String
    let prayer: String
    let reflection: String
    let reference: String
    let theme: String
    let verses: [ScriptureVerse]
    let xp: Int
    let gems: Int
    var keys: Int
    var fromOnboarding: Bool
    
    
    enum CodingKeys: String, CodingKey {
           case actionStep, date, prayer, reflection, reference, theme, verses, xp, gems, keys, fromOnboarding
       }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        actionStep = try container.decode(String.self, forKey: .actionStep)
        date = try container.decode(String.self, forKey: .date)
        prayer = try container.decode(String.self, forKey: .prayer)
        reflection = try container.decode(String.self, forKey: .reflection)
        reference = try container.decode(String.self, forKey: .reference)
        theme = try container.decode(String.self, forKey: .theme)
        verses = try container.decode([ScriptureVerse].self, forKey: .verses)
        xp = try container.decode(Int.self, forKey: .xp)
        gems = try container.decode(Int.self, forKey: .gems)
        keys = try container.decodeIfPresent(Int.self, forKey: .keys) ?? 0
        fromOnboarding = try container.decodeIfPresent(Bool.self, forKey: .fromOnboarding) ?? false
    }
    
    init(actionStep: String,
         date: String, prayer: String,
         reflection: String, reference: String,
         theme: String,
         xp: Int,
         gems: Int,
         verses: [ScriptureVerse]
    ) {
        self.actionStep = actionStep
        self.date = date
        self.prayer = prayer
        self.reflection = reflection
        self.reference = reference
        self.theme = theme
        self.verses = verses
        self.xp = xp
        self.gems = gems
        self.keys = 0
        self.fromOnboarding = false
    }
    
    static func == (lhs: DailyScripture, rhs: DailyScripture) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct ScriptureVerse: Codable, Identifiable, Hashable {
    var id: String { vs }

    let vs: String
    let translations: [VerseTransaction]
    
    static func == (lhs: ScriptureVerse, rhs: ScriptureVerse) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct VerseTransaction: Codable, Identifiable, Hashable {
    var id: String { "\(book)-\(reference)"}
    
    let book: String
    let text: String
    let reference: String
    
    
    static func == (lhs: VerseTransaction, rhs: VerseTransaction) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

