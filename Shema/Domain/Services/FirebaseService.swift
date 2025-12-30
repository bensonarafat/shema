//
//  BaseService.swift
//  Shema
//
//  Created by Benson Arafat on 28/12/2025.
//

import Foundation
import FirebaseFirestore

class FirebaseService {
    let db: Firestore
 
    init(db: Firestore = Firestore.firestore()) {
        self.db = db
    }
    
}
