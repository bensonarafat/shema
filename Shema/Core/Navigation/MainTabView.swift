//
//  MainTabView.swift
//  Shema
//
//  Created by Benson Arafat on 24/03/2026.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        TabView (selection: $router.activeTab) {
            ForEach(AppTabs.allCases) { tab in 
                tabView(for: tab)
                    .tabItem {
                        Label(tab.label, systemImage: tab.icon)
                    }
                    .tag(tab)
            }
        }
    }
    
    @ViewBuilder
    private func tabView (for tab: AppTabs) -> some View {
        switch tab {
        case .home:
            NavigationStack(path: $router.homePath) {
                HomeView()
                    .navigationDestination(for: AppRoute.self) { $0.destination }
            }
        case .bible:
            NavigationStack (path: $router.biblePath ) {
                BibleView()
                    .navigationDestination(for: AppRoute.self) { $0.destination }
            }
        case .settings:
            NavigationStack (path: $router.settingsPath) {
                SettingsView()
                    .navigationDestination(for: AppRoute.self) { $0.destination }
            }
        case .more:
            NavigationStack (path: $router.morePath) {
                MoreView()
                    .navigationDestination(for: AppRoute.self) { $0.destination }
            }
        }
    }
}

#Preview {
    MainTabView()
}
