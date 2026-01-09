//
//  UIColor+Extensions.swift
//  Shema
//
//  Created by Benson Arafat on 08/10/2025.
//

import Foundation
import SwiftUI

extension Color {
    init (hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 8
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init (
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    
    static let theme = ColorTheme()
}

struct ColorTheme {
    let primaryColor = Color("PrimaryColorFeatherGreen")
    let secondaryColor = Color("SecondaryColorMaskGreen")
    let backgroundColor = Color("BackgroundColorEel")
    let surfaceColor = Color("SurfaceColorWolf")
    let disabledTextColor = Color("DisabledTextColorSwan")
    let primaryTextColor = Color("PrimaryTextColorSnow")
    let secondaryTextColor = Color("SecondaryTextColorPolar")
    let macaw = Color("Macaw")
    let humpback = Color("Humpback")
}
