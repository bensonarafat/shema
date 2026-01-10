//
//  BookmarkService.swift
//  Shema
//
//  Created by Benson Arafat on 09/01/2026.
//

import Foundation
import FirebaseFirestore

class BookmarkService: FirebaseService {
    
    private func bookmarkRef(userId: String) -> CollectionReference {
        db.collection("users")
            .document(userId)
            .collection("bookmarks")
    }
    
    func syncToFirebase(_ bookmark: Bookmark, userId: String) async throws {
        try bookmarkRef(userId: userId)
            .document(bookmark.id)
            .setData(from: bookmark, merge: true)
    }
    
    func fetchUserBookmarks(userId: String) async throws -> [Bookmark] {
        let snapshot = try await bookmarkRef(userId: userId)
            .order(by: "createdAt", descending: true)
            .getDocuments()

        return snapshot.documents.compactMap { doc in
            try? doc.data(as: Bookmark.self)
        }
    }
    
    
    func deleteBookmark(id: String, userId: String) async throws {
        try await bookmarkRef(userId: userId)
            .document(id).delete()
    }
}
