//
//  AppleSignInDelegate.swift
//  Shema
//
//  Created by Benson Arafat on 01/01/2026.
//

import Foundation
import FirebaseAuth
import AuthenticationServices

class AppleSignInDelegate: NSObject, ASAuthorizationControllerDelegate {
    var continuation: CheckedContinuation<User, Error>?
    var currentNonce: String?
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let nonce = currentNonce,
              let appleIDToken = appleIDCredential.identityToken,
              let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            continuation?.resume(throwing: AuthError.appleSignInFailed)
            return
        }
        
        let credential = OAuthProvider.appleCredential(
            withIDToken: idTokenString,
            rawNonce: nonce,
            fullName: appleIDCredential.fullName
        )
        
        Task {
            do {
                let authResult = try await Auth.auth().signIn(with: credential)
                self.continuation?.resume(returning: authResult.user)
            } catch {
                self.continuation?.resume(throwing: AuthError.appleSignInFailed)
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        continuation?.resume(throwing: AuthError.appleSignInFailed)
    }
}
