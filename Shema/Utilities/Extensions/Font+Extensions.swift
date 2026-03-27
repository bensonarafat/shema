//
//  Font+Extensions.swift
//  Shema
//
//  Created by Benson Arafat on 29/12/2025.
//

import Foundation
import SwiftUI

extension Font {
    static func nunito(_ weight: NunitoWeight, size: CGFloat) -> Font {
        .custom(weight.fontName, size: size)
    }
}
