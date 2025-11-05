//
//  FocusViewModel.swift
//  Shema
//
//  Created by Benson Arafat on 05/11/2025.
//

import Foundation
import Combine

class FocusViewModel: ObservableObject {
    @Published var focuses : [Focus] = []
    
    init () {
        loadAllFocuses()
    }
    
    func loadAllFocuses() {
        self.focuses = Focus.allFocuses
    }
    
    func loadMinFocuses() -> [Focus] {
        return Array(Focus.allFocuses.prefix(5))
    }
}
