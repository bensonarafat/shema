//
//  BibleModels.swift
//  Shema
//
//  Created by Benson Arafat on 20/11/2025.
//

import Foundation

struct Language: Codable, Identifiable {
    let language: String
    let translations: [Translation]
    
    var id: String { language }
    
}

struct Translation: Codable, Identifiable {
    let shortName: String
    let fullName: String
    let updated: Date
    let dir: String?
    
    var id: String { shortName }
    
    enum CodingKeys: String, CodingKey {
        case shortName = "short_name"
        case fullName = "full_name"
        case updated
        case dir
    }
}


struct Book: Codable, Identifiable {
    let bookid: Int
    let chronorder: Int
    let name: String
    let chapters: Int
    
    var id: Int { bookid }
}

struct BibleReference: Hashable {
    let book: Int
    let chapter: Int
    let verse: Int?
    let translation: String
}


struct Verse: Codable, Identifiable {
    let pk: Int
    let translation: String?
    let book: Int?
    let chapter: Int?
    let verse: Int
    let text: String
    let comment: String?
    
    var id: Int { pk }
    
    var cleanText: String {
        text.replacingOccurrences(of: "<[^>]+>",with: "", options: .regularExpression)
    }
    
    var cleanComment: String {
        comment?.replacingOccurrences(of: "<[^>]+>",with: "", options: .regularExpression) ?? ""
    }
}

struct SearchResult: Codable {
    let exactMatches: Int
    let total: Int
    let results: [Verse]
    
    enum CodingKeys: String, CodingKey {
        case exactMatches = "exact_matches"
        case total
        case results
    }
}


