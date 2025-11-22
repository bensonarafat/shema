//
//  BibleService.swift
//  Shema
//
//  Created by Benson Arafat on 20/11/2025.
//

import Foundation
import Combine

class BibleService: BibleServiceProtocol {
    
    static let shared = BibleService()
    private let decoder = JSONDecoder();
    private let baseURL = "https://bolls.life"
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    
    private func fetch<T: Decodable> (_ url: URL) -> AnyPublisher<T, BibleAPIError> {
        session.dataTaskPublisher(for: url)
            .mapError { BibleAPIError.networkError($0) }
            .handleEvents(receiveOutput: { data, _ in
                print("RAW JSON", String(data: data, encoding: .utf8) ?? "nil")
            })
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .mapError { error in
                if let apiError = error as? BibleAPIError { return apiError }
                return BibleAPIError.decodingError(error)
            }
            .eraseToAnyPublisher()
    }
    
    
    func fetchLanguages() -> AnyPublisher<[Language],  BibleAPIError> {
        guard let url = URL(string: "\(baseURL)/static/bolls/app/views/languages.json") else {
            return Fail(error: BibleAPIError.invalidURL).eraseToAnyPublisher()
        }
        return fetch(url)
    }
    
    func fetchBooks(for translation: String) -> AnyPublisher<[Book],  BibleAPIError> {
        guard let url = URL(string: "\(baseURL)/get-books/\(translation)") else {
            return Fail(error: BibleAPIError.invalidURL).eraseToAnyPublisher()
        }
        return fetch(url)
    }
    
    func fetchChapter(translation: String, book: Int, chapter: Int) -> AnyPublisher<[Verse], BibleAPIError> {
        guard let url = URL(string: "\(baseURL)/get-text/\(translation)/\(book)/\(chapter)") else {
            return Fail(error: BibleAPIError.invalidURL).eraseToAnyPublisher()
        }
        return fetch(url)
    }
    
    
    func fetchVerse(translation: String, book: Int, chapter: Int, verse: Int) -> AnyPublisher<Verse, BibleAPIError> {
        guard let url = URL(string: "\(baseURL)/get-verse/\(translation)/\(book)/\(chapter)/\(verse)") else {
            return Fail(error: BibleAPIError.invalidURL).eraseToAnyPublisher()
        }
        return fetch(url)
    }
    
    func search(transation: String, query: String, matchCase: Bool, matchWhole: Bool, book: String?) -> AnyPublisher<SearchResult, BibleAPIError> {
        var components = URLComponents(string: "\(baseURL)/v2/find/\(transation)")!
        var queryItems = [URLQueryItem(name: "search", value: query),
                          URLQueryItem(name: "match_case", value: "\(matchCase)"),
                          URLQueryItem(name: "match_whole", value: "\(matchWhole)")
        ]
        
        if let book = book {
            queryItems.append(URLQueryItem(name: "book", value: book))
        }
        
        components.queryItems = queryItems
        
        guard let url = components.url else {
            return Fail(error: BibleAPIError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return fetch(url)
    }
    
    func fetchRandomVerse(translation: String) -> AnyPublisher<Verse, BibleAPIError> {
        guard let url = URL(string: "\(baseURL)/get-random-verse/\(translation)") else {
            return Fail(error: BibleAPIError.invalidURL).eraseToAnyPublisher()
        }
        return fetch(url)
    }
    
    func downloadTransalation(_ translation: String) -> AnyPublisher<URL, BibleAPIError> {
        guard let url = URL(string: "\(baseURL)/static/translations/\(translation).json") else {
            return Fail(error: BibleAPIError.invalidURL).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: url)
            .mapError { BibleAPIError.networkError($0) }
            .tryMap { data, _ -> URL in
                let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let dest = docs.appendingPathComponent("\(translation).json")
                try? FileManager.default.removeItem(at: dest)
                try data.write(to: dest)
                return dest
            }
            .mapError { error in
                if let apiError = error as? BibleAPIError { return apiError }
                return BibleAPIError.fileError(error)
            }
            .eraseToAnyPublisher()
    }
}
