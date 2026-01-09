//
//  BibleServiceProtocol.swift
//  Shema
//
//  Created by Benson Arafat on 20/11/2025.
//

import Foundation
import Combine

protocol BibleServiceProtocol {
    func fetchLanguages() -> AnyPublisher<[Language], BibleAPIError>
    func fetchChapter(translation: String, book: Int, chapter: Int) -> AnyPublisher<[Verse], BibleAPIError>
    func fetchVerse(translation: String, book: Int, chapter: Int, verse: Int) -> AnyPublisher<Verse, BibleAPIError>
    func search(transation: String, query: String, matchCase: Bool, matchWhole: Bool, book: String?) -> AnyPublisher<SearchResult, BibleAPIError>
    func fetchRandomVerse(translation: String) -> AnyPublisher<Verse, BibleAPIError>
    func downloadTransalation(_ translation: String) -> AnyPublisher<URL, BibleAPIError>
}
