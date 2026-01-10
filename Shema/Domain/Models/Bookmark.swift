//
//  Bookmark.swift
//  Shema
//
//  Created by Benson Arafat on 09/01/2026.
//

import Foundation

struct Bookmark: Codable, Identifiable, Hashable{
    let id: String
    let actionStep: String
    let date: String
    let prayer: String
    let reference: String
    let reflection: String
    let theme: String
    let verses: [BookmarkVerse]
    let createdAt: Date
    
    init(id: String, actionStep: String,
         date: String, prayer: String, reference: String,
         reflection: String, theme: String, verses: [BookmarkVerse],
         createdAt: Date = Date() ) {
        self.id = id
        self.actionStep = actionStep
        self.date = date
        self.prayer = prayer
        self.reference = reference
        self.reflection = reflection
        self.theme = theme
        self.verses = verses
        self.createdAt = createdAt
    }
    
    
    static func == (lhs: Bookmark, rhs: Bookmark) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct BookmarkVerse : Codable, Identifiable, Hashable{
    var id: String { vs }
    let vs: String
    let book: String
    let reference: String
    let text: String
    
    init(vs: String, book: String, reference: String, text: String) {
        self.vs = vs
        self.book = book
        self.reference = reference
        self.text = text
    }
    
    
    static func == (lhs: BookmarkVerse, rhs: BookmarkVerse) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
