//
//  ScriptureService.swift
//  Shema
//
//  Created by Benson Arafat on 08/01/2026.
//

import Foundation
import Combine
import FirebaseFirestore

class ScriptureService : FirebaseService, ObservableObject {
    @Published var scripture: DailyScripture?
    @Published var selectedTranslation: String = "KJV"
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isUsingCache = false
    
    private let cacheKeyPrefix = "daily_scripture_"
    private let lastCacheUpdateKey = "last_cache_update_date"
    private var translationKey = "translationKey"
    private let userDefault = UserDefaults.standard;
    
    init() {
        super.init()
        selectedTranslation = userDefault.string(forKey: selectedTranslation) ?? selectedTranslation
        clearOldCacheIfNeeded()
    }
    
    
    func getScripture() async {
        await MainActor.run { isLoading = true }
        
        // First try to get from cache
        if let cachedScripture = await getCachedScripture() {
            await MainActor.run  {
                self.scripture = cachedScripture
                self.isUsingCache = true
                self.errorMessage = nil
                self.isLoading = false
            }
            
            // Still fetch fresh data in background
            Task {
                await fetchFreshScripture()
            }
            return
        }
        
        await fetchFreshScripture()
    }
    
    func refreshScripture() async {
        await MainActor.run  {
            isLoading = true
            isUsingCache = false
        }
        await fetchFreshScripture(forceRefresh: true)
    }
    
    func clearCache() {
        let keys = userDefault.dictionaryRepresentation().keys
        for key in keys where key.hasPrefix(cacheKeyPrefix) {
            userDefault.removeObject(forKey: key)
        }
        userDefault.removeObject(forKey: lastCacheUpdateKey)
    }
    
    private func fetchFreshScripture(forceRefresh: Bool = false) async {
        do {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let currentDate = formatter.string(from: Date())
            let document = try await db.collection("dailyScriptures")
                .document(currentDate)
                .getDocument()
            guard document.exists else {
                await MainActor.run {
                    self.errorMessage = "Scripture not found for today"
                    self.isLoading = false
                }
                return
            }
            
            guard let scripture  = try? document.data( as: DailyScripture.self ) else {
                await MainActor.run {
                    self.errorMessage = "Failed to parse scripture"
                    self.isLoading = false
                }
                return
            }
            
            cacheScripture(scripture, for: currentDate)
            
            await MainActor.run {
                self.scripture = scripture
                self.isUsingCache = false
                self.errorMessage = nil
                self.isLoading = false
            }
            
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
    
    private func getCachedScripture() async -> DailyScripture? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDate = formatter.string(from: Date())
        let cacheKey = "\(cacheKeyPrefix)\(currentDate)"
        
        // Check if we have cache for today
        guard let cacheData = userDefault.data(forKey: cacheKey) else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            
            let cacheScripture = try decoder.decode(DailyScripture.self, from: cacheData)
            
            // Verify the cached scripture is for today
            guard cacheScripture.date == currentDate else {
                userDefault.removeObject(forKey: cacheKey)
                return nil
            }
            
            return cacheScripture
        } catch {
            print("Failed to decode cache scripture: \(error)")
            userDefault.removeObject(forKey: cacheKey)
            return nil
        }
    }
    
    
    private func cacheScripture(_ scripture: DailyScripture, for date: String) {
        let cacheKey = "\(cacheKeyPrefix)\(date)"
        
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .secondsSince1970
            
            let encodedData = try encoder.encode(scripture)
            userDefault.set(encodedData, forKey: cacheKey)
            userDefault.set(Date(), forKey: lastCacheUpdateKey)
            
            print("Scripture cached for \(date)")
        } catch {
            print("Failed to cache scripture: \(error)")
        }
    }
    
    
    private func clearOldCacheIfNeeded() {
        guard let lastUpdate = userDefault.object(forKey: lastCacheUpdateKey) as? Date else {
            return
        }
        let calendar = Calendar.current
        if !calendar.isDateInToday(lastUpdate) {
            clearCache()
        }
    }
    
    
    func getVerseText(_ verse: ScriptureVerse) -> String {
        if let preferredVerse = verse.translations.first( where: { $0.book == selectedTranslation }) {
                return preferredVerse.text
        }
        return verse.translations.first?.text ?? ""
    }
    
    func getVerseReference(_ verse: ScriptureVerse) -> String {
        if let preferredVerse = verse.translations.first( where: { $0.book == selectedTranslation}) {
            return preferredVerse.reference
        }
        return verse.translations.first?.reference ?? verse.vs
    }
    
    func getTranslationName() -> String {
        selectedTranslation
    }
    
    
}

