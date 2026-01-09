//
//  CustomTabBar.swift
//  Shema
//
//  Created by Benson Arafat on 02/01/2026.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Tabs
    
    var body: some View {
        HStack {
            TabBarItem(tab: .home, image: "home",name: "Home", selectedTab: $selectedTab)
            TabBarItem(tab: .bible, image: "book",name: "Bible", selectedTab: $selectedTab)
//               TabBarItem(tab: .achievements, image: "cup", selectedTab: $selectedTab)
            TabBarItem(tab: .bookmark, image: "bookmark", name: "Bookmark", selectedTab: $selectedTab)
            TabBarItem(tab: .settings, image: "settings", name: "Settings", selectedTab: $selectedTab)
            TabBarItem(tab: .profile, image: "profile", name: "Profile", selectedTab: $selectedTab)
           }
        .frame(height: 65)
        .background(Color.theme.backgroundColor)
        .padding(.horizontal, 16)
        .padding(.bottom, 18)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.white.opacity(0.1)),
            alignment: .top
        )
        .overlay(
            Rectangle()
                .fill(Color.black.opacity(0.15))
                .blur(radius: 6)
                .frame(height: 6),
            alignment: .top
        )
       
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(.home))
}
