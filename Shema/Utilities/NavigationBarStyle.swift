//
//  NavigationBarStyle.swift
//  Shema
//
//  Created by Benson Arafat on 11/01/2026.
//

import SwiftUI
import UIKit

struct NavigationBarStyle {
    static func apply() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        // Convert SwiftUI Color to UIColor appropriately for current trait environment
        let backgroundUIColor = UIColor(Color.theme.backgroundColor)
        appearance.backgroundColor = backgroundUIColor
        
        let primaryTextUIColor = UIColor(Color.theme.primaryTextColor)
        appearance.titleTextAttributes = [
            .foregroundColor: primaryTextUIColor
        ]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: primaryTextUIColor
        ]
        
        UINavigationBar.appearance().standardAppearance = appearance
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
}
