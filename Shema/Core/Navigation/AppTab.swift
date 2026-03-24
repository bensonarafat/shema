//
//  AppTab.swift
//  Shema
//
//  Created by Benson Arafat on 24/03/2026.
//

import Foundation

enum AppTabs: Equatable, Hashable, CaseIterable, Identifiable {
    case home
    case bible
    case settings
    case more
    
    var id: Self { self }
    
    var label: String {
        switch self {
        case .home: return "Home"
        case .bible: return "Bible"
        case .settings: return "Settings"
        case .more: return "More"
        }
    }
    
    var icon: String {
        switch self {
        case .home: return "homepod.mini"
        case .bible: return "book.pages"
        case .settings: return "gearshape"
        case .more: return "ellipsis"
//        case .bible: return "magnifyingglass"
        }
    }
    
    var activeIcon: String {
        switch self {
        case .home: return "homepod.mini.fill"
        case .bible: return "book.pages.fill"
        case .settings: return "gearshape.fill"
        case .more: return "ellipsis"
//        case .bible: return "magnifyingglass"
        }
    }
}
