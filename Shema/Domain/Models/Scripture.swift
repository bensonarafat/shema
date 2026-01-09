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
    
    init(actionStep: String,
         date: String, prayer: String,
         reflection: String, reference: String,
         theme: String,
         verses: [ScriptureVerse]
    ) {
        self.actionStep = actionStep
        self.date = date
        self.prayer = prayer
        self.reflection = reflection
        self.reference = reference
        self.theme = theme
        self.verses = verses
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

