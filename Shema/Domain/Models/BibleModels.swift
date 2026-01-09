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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        shortName = try container.decode(String.self, forKey: .shortName)
        fullName = try container.decode(String.self, forKey: .fullName)
        dir = try container.decodeIfPresent(String.self,forKey: .dir)
        
        let timestamp = try container.decode(Double.self, forKey: .updated)
        updated = Date(timeIntervalSince1970: timestamp / 1000)
    }
}


struct Book: Codable, Identifiable {
    let bookid: Int
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
        text.replacingOccurrences(
               of: "<[^>]+>[^<]*</[^>]+>",
               with: "",
               options: .regularExpression
           )
    }
    
    var cleanComment: String {
        comment?.replacingOccurrences(
            of: "<[^>]+>[^<]*</[^>]+>",
            with: "",
            options: .regularExpression
        ) ?? ""
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

struct BibleArg: Hashable, Codable {
    let verses: [Verse]
    let chapter: Int
    let book: Book?
    
    init(verses: [Verse], chapter: Int, book: Book?) {
        self.verses = verses
        self.chapter = chapter
        self.book = book
    }
    
    static func == (lhs: BibleArg, rhs: BibleArg) -> Bool {
        return lhs.chapter == rhs.chapter
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(chapter)
    }
}


