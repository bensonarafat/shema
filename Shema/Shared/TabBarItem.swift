//
//  TabBarItem.swift
//  Shema
//
//  Created by Benson Arafat on 02/01/2026.
//

import SwiftUI

struct TabBarItem: View {
    let tab: Tabs
    let image: String
    
    @Binding var selectedTab: Tabs
    
    var isSelected: Bool {
        selectedTab == tab
    }
    
    
    var body: some View {
        Button {
            selectedTab = tab
        } label: {
            ZStack {
                if isSelected {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.blue.opacity(0.2))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.blue, lineWidth: 2)
                        )
                        .frame(width: 45, height: 45)
                }
                
                Image(image)
                   .resizable()
                   .scaledToFit()
                   .frame(width: 35, height: 35)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var selected: Tabs = .home
        var body: some View {
            TabBarItem(
                tab: .home,
                image: "home",
                selectedTab: $selected
            )
            .frame(width: 60, height: 60)
            .padding()
            .background(Color(.systemBackground))
        }
    }
    return PreviewWrapper()
}
