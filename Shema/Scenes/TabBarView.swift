//
//  TabBarView.swift
//  Shema
//
//  Created by Benson Arafat on 19/10/2025.
//

import SwiftUI

struct TabBarView: View {
    @State private var selected = 0
    
    var body: some View {
        TabView (selection: $selected) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }.tag(0)
            BibleReaderView ()
                .tabItem {
                    Label("Bible", systemImage: "book")
                }.tag(1)
            BookmarkView()
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
                .tag(2)
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }.tag(3)
        }
    }
}

#Preview {
    TabBarView()
}
