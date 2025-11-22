//
//  FamilyControlViewModel.swift
//  Shema
//
//  Created by Benson Arafat on 21/11/2025.
//

import Foundation
import Combine

class FamilyControlViewModel: ObservableObject {
    
    @Published var showingAppPicker = false
    
    var appBlockingService = AppBlockingService.shared
    let bibleService = BibleService.shared
    let notificationService = NotificationService.shared
    
    
    func updateAppBlockingStatus() {
        
    }
}
