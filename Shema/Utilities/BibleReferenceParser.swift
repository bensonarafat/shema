//
//  BibleReferenceParser.swift
//  Shema
//
//  Created by Benson Arafat on 21/11/2025.
//

import Foundation

class BibleReferenceParser {
    static let shared = BibleReferenceParser()
    
    private let bookAliases: [String: Int] = [
        "genesis": 1, "gen": 1, "exodus": 2, "ex": 2, "leviticus": 3, "lev": 3,
        "numbers": 4, "num": 4, "deuteronomy": 5, "deut": 5, "joshua": 6, "josh": 6,
        "judges": 7, "judg": 7, "ruth": 8, "1 samuel": 9, "1 sam": 9, "2 samuel": 10,
        "2 sam": 10, "1 kings": 11, "2 kings": 12, "1 chronicles": 13, "2 chronicles": 14,
        "ezra": 15, "nehemiah": 16, "esther": 17, "job": 18, "psalms": 19, "psalm": 19,
        "ps": 19, "proverbs": 20, "prov": 20, "ecclesiastes": 21, "song of solomon": 22,
        "isaiah": 23, "isa": 23, "jeremiah": 24, "jer": 24, "lamentations": 25,
        "ezekiel": 26, "daniel": 27, "dan": 27, "hosea": 28, "joel": 29, "amos": 30,
        "obadiah": 31, "jonah": 32, "micah": 33, "nahum": 34, "habakkuk": 35,
        "zephaniah": 36, "haggai": 37, "zechariah": 38, "malachi": 39,
        "matthew": 40, "matt": 40, "mark": 41, "luke": 42, "john": 43, "acts": 44,
        "romans": 45, "rom": 45, "1 corinthians": 46, "1 cor": 46, "2 corinthians": 47,
        "2 cor": 47, "galatians": 48, "gal": 48, "ephesians": 49, "eph": 49,
        "philippians": 50, "phil": 50, "colossians": 51, "col": 51,
        "1 thessalonians": 52, "2 thessalonians": 53, "1 timothy": 54, "2 timothy": 55,
        "titus": 56, "philemon": 57, "hebrews": 58, "heb": 58, "james": 59,
        "1 peter": 60, "2 peter": 61, "1 john": 62, "2 john": 63, "3 john": 64,
        "jude": 65, "revelation": 66, "rev": 66
    ]
    
    func parse (_ input: String, defaultTranslation: String = "KJV") -> BibleReference? {
        let cleaned = input.lowercased()
            .replacingOccurrences(of: "vs", with: ":")
            .replacingOccurrences(of: "verse", with: ":")
            .replacingOccurrences(of: "chapter", with: " ")
        
        let pattern = #"([1-3]?\s?[a-z]+)\s*(\d+)(?::(\d+))?"#
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive),
              let match = regex.firstMatch(in: cleaned, range: NSRange(cleaned.startIndex..., in: cleaned)) else {
            return nil
        }
        
        let bookStr = String(cleaned[Range(match.range(at: 1), in: cleaned)!]).trimmingCharacters(in: .whitespaces)
        let chapterStr = String(cleaned[Range(match.range(at: 2), in: cleaned)!])
        let verseStr = match.range(at: 3).location != NSNotFound
        ? String(cleaned[Range(match.range(at: 3), in: cleaned)!]) : nil
        
        guard let bookId = bookAliases[bookStr], let chapter = Int(chapterStr) else { return nil }
        
        return BibleReference(book: bookId, chapter: chapter, verse: verseStr.flatMap { Int($0) }, translation: defaultTranslation)
    }
}

