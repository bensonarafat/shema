//
//  String+Extensions.swift
//  Shema
//
//  Created by Benson Arafat on 08/10/2025.
//

import Foundation


extension String {
    var usernameFromEmail: String {
        return self.components(separatedBy: "@").first ?? self
    }
    
    var isValidUsername: Bool {
           let usernameRegex = "^[a-zA-Z0-9_]{3,20}$"
           let usernamePredicate = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
           return usernamePredicate.evaluate(with: self)
       }
}
