//
//  UserService.swift
//  Shema
//
//  Created by Benson Arafat on 31/12/2025.
//

import Foundation
import FirebaseFirestore


class UserService: FirebaseService {
 
    
    func createUser(shemaUser: ShemaUser) async throws -> ShemaUser {
        let emailExists = try await checkIfEmailExist(email: shemaUser.email)
        if emailExists {
            throw UserServiceError.emailAlreadyExists
        }
        do {
            try db.collection("users")
                .document(shemaUser.id)
                .setData(from: shemaUser)
            return shemaUser
        } catch {
            
            print("Error fom here \(error.localizedDescription)")
            throw UserServiceError.unknownError(error.localizedDescription)
        }
    }
    
    func getUser(userId: String)  async throws ->  ShemaUser {
        do {
            let document = try await db.collection("users")
                .document(userId)
                .getDocument()
            
            guard document.exists else {
                throw UserServiceError.userNotFound
            }
            
            guard let user = try? document.data(as: ShemaUser.self) else {
                throw UserServiceError.invalidData
            }
            return user
        } catch let error as UserServiceError {
            throw error
        } catch {
            throw UserServiceError.unknownError(error.localizedDescription)
        }
    }
    
    func getUserByEmail (email: String) async throws -> ShemaUser? {
        do {
            let snapshot = try await db.collection("users")
                .whereField("email", isEqualTo: email)
                .getDocuments()
            
            guard let document = snapshot.documents.first else {
                return nil
            }
            return try document.data( as: ShemaUser.self)
        } catch {
            throw UserServiceError.unknownError(error.localizedDescription)
        }
    }
    
    func checkIfEmailExist(email: String) async throws -> Bool {
        do {
            let snapshot = try await db.collection("users")
                .whereField("email", isEqualTo: email)
                .getDocuments()
            return !snapshot.documents.isEmpty
        } catch {
            throw UserServiceError.unknownError(error.localizedDescription)
        }
    }
    
    func updateUser(shemaUser: ShemaUser) async throws -> ShemaUser {
        do {
            try db.collection("users")
                .document(shemaUser.id)
                .setData(from: shemaUser, merge: true)
            return shemaUser
        } catch {
            throw UserServiceError.unknownError(error.localizedDescription)
        }
    }
    
    func updateLastLogin(userId: String) async throws {
        do {
            try await db.collection("users")
                .document(userId)
                .updateData(["lastLogin": Timestamp(date: Date())])
        } catch {
            throw UserServiceError.unknownError(error.localizedDescription)
        }
    }
    
    func deleteUser(userId: String) async throws -> Bool {
        do {
            try await db.collection("users")
                .document(userId)
                .delete()
            return true
        } catch {
            throw UserServiceError.deletionFailed
        }
    }
    
    func deleteUserbyEmail(email: String) async throws -> Bool {
        do {
            guard let user = try await getUserByEmail(email: email) else {
                throw UserServiceError.userNotFound
            }
            return try await deleteUser(userId: user.id)
        } catch {
            throw error
        }
    }
}
