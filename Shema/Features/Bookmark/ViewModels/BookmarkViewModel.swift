//
//  BookmarkViewModel.swift
//  Shema
//
//  Created by Benson Arafat on 09/01/2026.
//

import Foundation
import Combine
import FirebaseAuth

class BookmarkViewModel: ObservableObject {
    @Published var bookmarks: [Bookmark] = []
    @Published var selectedTranslation: String = "KJV"
    private var bookmarkService: BookmarkService
    private var authService: AuthService

    private var userDefault = UserDefaults.standard
    private let bookmarkKey = "local_bookmark"
    private var translationKey = "translationKey"
    
    init(bookmarkService: BookmarkService = BookmarkService(),
         authService: AuthService = AuthService()) {
        self.bookmarkService = bookmarkService
        self.authService = authService
        self.selectedTranslation = userDefault.string(forKey: translationKey) ?? selectedTranslation
        fetchBookmarks()
    }
    
    
    func fetchBookmarks() {
        guard let data = userDefault.data(forKey: bookmarkKey) else { return }
        if let cached = try?  JSONDecoder().decode([Bookmark].self, from: data) {
            self.bookmarks = cached
        }
    }

    
    func addBookmark (_ scripture: DailyScripture) async {
        var verses: [BookmarkVerse] = []
        for verse in scripture.verses {
            // Try to find the selected translation; if unavailable, fall back to the first available translation.
            let chosenTranslation: VerseTransaction? = verse.translations.first(where: { $0.book == selectedTranslation }) ?? verse.translations.first
            guard let translation = chosenTranslation else {
                // No translations available for this verse; skip adding it.
                continue
            }
            verses.append(BookmarkVerse(vs: verse.vs, book: translation.book, reference: translation.reference, text: translation.text))
        }
        let bookmark = Bookmark(id: scripture.id, actionStep: scripture.actionStep, date: scripture.date, prayer: scripture.prayer, reference: scripture.reference, reflection: scripture.reflection, theme: scripture.theme, verses: verses)
        guard !bookmarks.contains(bookmark) else { return }
        bookmarks.insert(bookmark, at: 0)
        saveLocalBookmarks()
        guard let userId = authService.currentUser?.uid else {
            return;
        }
        try? await bookmarkService.syncToFirebase(bookmark, userId: userId)
    }
    
    func deleteBookmark(_ id: String) async {
       await deleteBookmarkLocally(id)
       await deleteBookmarkRemote(id)
    }
    
    func deleteBookmarkRemote(_ id: String ) async {
        guard let userId = authService.currentUser?.uid else {
            return;
        }
        do {
            try await bookmarkService.deleteBookmark(id: id, userId: userId)
            bookmarks.removeAll { $0.id == id }
        } catch {
            print("Failed to delete bookmark", error)
        }
    }
    
    func isSaved(_ id : String) -> Bool {
        bookmarks.contains ( where: { $0.id == id })
    }
    
    func deleteBookmarkLocally (_ id: String) async {
        bookmarks.removeAll { $0.id == id }
        saveLocalBookmarks()
    }
    
    private func saveLocalBookmarks() {
        if let data = try? JSONEncoder().encode(bookmarks) {
            userDefault.set(data, forKey: bookmarkKey)
        }
    }

}

