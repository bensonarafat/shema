//
//  HomeViewModel.swift
//  Shema
//
//  Created by Benson Arafat on 03/11/2025.
//

import Foundation
import Combine
import SwiftUI

struct GreetingsModel {
    var text: String
    var icon: String
    
    init(text: String, icon: String) {
        self.text = text
        self.icon = icon
    }
}

@MainActor
class HomeViewModel: ObservableObject {
    @Published var greetings: GreetingsModel = GreetingsModel(text: "", icon: "")
    
    init () {
        updateGreetings()
    }
    
    func updateGreetings() {
        let hour = Calendar.current.component(.hour, from: Date())
        greetings = getGreetings(for: hour)
    }
    
    
    func getGreetings(for hour: Int) -> GreetingsModel {
        switch hour {
        case 5..<12:
            return GreetingsModel(text: "GOOD MORNING", icon: "sun.max.fill")
        case 12..<18:
            return GreetingsModel(text: "GOOD AFTERNOON", icon: "sun.haze.fill")
        case 17..<21:
            return GreetingsModel(text: "GOOD EVENING", icon: "sunset.fill")
        default:
            return GreetingsModel(text: "GOOD NIGHT", icon: "moon.stars.fill")
        }
    }
}
