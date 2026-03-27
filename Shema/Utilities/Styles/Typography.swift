//
//  Typography.swift
//  Shema
//
//  Created by Benson Arafat on 24/03/2026.
//

import Foundation
import SwiftUI

enum NunitoWeight {
    case regular, italic
     case extraLight, extraLightItalic
     case light, lightItalic
     case medium, mediumItalic
     case semibold, semiBoldItalic
     case bold, boldItalic
     case extraBold, extraBoldItalic
     case black, blackItalic
    
    var fontName: String {
           switch self {
           case .regular:          return "Nunito-Regular"
           case .italic:           return "Nunito-Italic"
           case .extraLight:       return "Nunito-ExtraLight"
           case .extraLightItalic: return "Nunito-ExtraLightItalic"
           case .light:            return "Nunito-Light"
           case .lightItalic:      return "Nunito-LightItalic"
           case .medium:           return "Nunito-Medium"
           case .mediumItalic:     return "Nunito-MediumItalic"
           case .semibold:         return "Nunito-SemiBold"
           case .semiBoldItalic:   return "Nunito-SemiBoldItalic"
           case .bold:             return "Nunito-Bold"
           case .boldItalic:       return "Nunito-BoldItalic"
           case .extraBold:        return "Nunito-ExtraBold"
           case .extraBoldItalic:  return "Nunito-ExtraBoldItalic"
           case .black:            return "Nunito-Black"
           case .blackItalic:      return "Nunito-BlackItalic"
           }
    }
}


extension Font {
    
    // MARK: - Titles
    static let appLargeTitle      = Font.nunito(.bold, size: 34)
    static let appDisplay         = Font.nunito(.extraBold, size: 28)
    static let appTitle           = Font.nunito(.medium, size: 24)
    static let appTitle2          = Font.nunito(.regular, size: 20)
    
    // MARK: - Headings
    static let appHeadingTitle    = Font.nunito(.medium, size: 20)
    static let appHeadingSubTitle = Font.nunito(.medium, size: 12)
    
    // MARK: - Body
    static let appBody            = Font.nunito(.medium, size: 14)
    static let appBodyRegular     = Font.nunito(.regular, size: 14)
    static let appBodySmall       = Font.nunito(.regular, size: 12)
    
    // MARK: - UI Text
    static let appSubheadline     = Font.nunito(.regular, size: 14)
    static let appFootnote        = Font.nunito(.regular, size: 18)
    static let appSubFootnote       = Font.nunito(.regular, size: 13)
    static let appCaption         = Font.nunito(.regular, size: 12)
    static let appCaptionBold     = Font.nunito(.semibold, size: 12)
    static let appMicro           = Font.nunito(.regular, size: 10)
    
    // MARK: - Buttons
    static let appButtonPrimary   = Font.nunito(.extraBold, size: 24)
    static let appButtonSecondary = Font.nunito(.medium, size: 18)
    static let appButtonSmall     = Font.nunito(.semibold, size: 16)
}
