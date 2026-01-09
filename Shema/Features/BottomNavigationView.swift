//
//  TabBarView.swift
//  Shema
//
//  Created by Benson Arafat on 19/10/2025.
//

import SwiftUI

struct BottomNavigationView: View {
    @State private var selected: Tabs  = Tabs.home
    
    var body: some View {
        VStack {
            Group {
                switch selected {
                case .home:
                    HomeView()
                case .bible:
                    BibleReaderView()
                case .achievements:
                    LevelView()
                case .bookmark:
                    BookmarkView()
                case .settings:
                    SettingsView()
                case .profile:
                    ProfileView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .safeAreaInset(edge: .bottom) {
                CustomTabBar(selectedTab: $selected)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    var nav = NavigationManager()
    BottomNavigationView().environmentObject(nav);
}
