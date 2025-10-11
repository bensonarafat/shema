//
//  BibleReading.swift
//  Shema
//
//  Created by Benson Arafat on 08/10/2025.
//

import Foundation

struct BibleReading: Identifiable, Codable {
    let id: UUID
    let book: String
    let chapter: Int
    let verses: String
    let content: String
    let isCompleted: Bool
    let date: Date
    
    init(book: String, chapter: Int, verses: String, content: String) {
        self.id = UUID()
        self.book = book
        self.chapter = chapter
        self.verses = verses
        self.content = content
        self.isCompleted = false
        self.date = Date()
    }
}


struct DailyReadingPlan: Codable {
    var currentDay: Int
    var totalDays: Int
    var readings: [BibleReading]
    var startDate: Date 
}
