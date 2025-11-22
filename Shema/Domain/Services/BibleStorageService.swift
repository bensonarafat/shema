//
//  BibleStorageService.swift
//  Shema
//
//  Created by Benson Arafat on 21/11/2025.
//

import Foundation
import Combine

class BibleStorageService {
    static let shared = BibleStorageService()
    private let fileManager = FileManager.default
    
    private var documentsURL: URL {
        fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func isDownloaded(_ translation: String) -> Bool {
        fileManager.fileExists(atPath: documentsURL.appendingPathComponent("\(translation).json").path)
    }
    
    func getDownloadedTransations() -> [String] {
        (try? fileManager.contentsOfDirectory(atPath: documentsURL.path))?
            .filter { $0.hasSuffix(".json") }
            .map { String($0.dropLast(5)) } ?? []
    }
    
    func loadOfflineVerses(translation: String, book: Int, chapter: Int ) -> AnyPublisher<[Verse], BibleAPIError> {
        Future<[Verse], BibleAPIError> { [weak self] promise in
            guard let self = self else {
                promise(.failure(.noData))
                return
            }
            
            do {
                let url = self.documentsURL.appendingPathComponent("\(translation).json")
                let data = try Data(contentsOf: url)
                let allVerses = try JSONDecoder().decode([Verse].self, from: data)
                let filtered = allVerses.filter { $0.book == book && $0.chapter == chapter }
                promise(.success(filtered))
            } catch {
                promise(.failure(.fileError(error)))
            }
        }
        .eraseToAnyPublisher()
    }
    
    
    func deleteTranslation(_ translation: String) throws {
        try fileManager.removeItem(at: documentsURL.appendingPathComponent("\(translation).json"))
    }
}
