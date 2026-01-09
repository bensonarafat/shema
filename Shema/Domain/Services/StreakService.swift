//
//  StreakService.swift
//  Shema
//
//  Created by Benson Arafat on 05/01/2026.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import Combine

class StreakService: FirebaseService {
    
    func syncToFirebase(_ streak: Streak) async throws {
        let data: [String: Any] = [
            "id": streak.id.uuidString,
            "userId": streak.userId,
            "date": Timestamp(date: streak.date)
        ]
        try await db.collection("streaks").document(streak.id.uuidString).setData(data)
    }
    
    func getStreaks(userId: String) async throws -> [Streak] {
        var remoteStreaks: [Streak] = []
        let snapshot = try await db.collection("streaks")
            .whereField("userId", isEqualTo: userId)
            .getDocuments()
        
        for document in snapshot.documents {
            if let id = UUID(uuidString: document.data()["id"] as? String ?? ""),
               let userId = document.data()["userId"] as? String,
               let timestamp = document.data()["date"] as? Timestamp {
                let streak = Streak(id: id, userId: userId, date: timestamp.dateValue())
                remoteStreaks.append(streak)
            }
        }
        
        return remoteStreaks
    }
    
    func deleteStreaks(userId: String) async throws {
        let snapshot = try await db.collection("streaks")
            .whereField("userId", isEqualTo: userId)
            .getDocuments()
          
        for document in snapshot.documents {
            try await document.reference.delete()
        }
    }
}
