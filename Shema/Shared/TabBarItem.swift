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
    let name: String
    
    @Binding var selectedTab: Tabs
    
    var isSelected: Bool {
        selectedTab == tab
    }
    
    
    var body: some View {
        Button {
            selectedTab = tab
        } label: {
            GeometryReader { geo in
                ZStack {
                    if isSelected {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.blue.opacity(0.2))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                            .frame(width: geo.size.width, height: 50)
                    }
                    VStack (spacing: 1) {
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                        
                        Text(name)
                            .font(.fontNunitoRegular(size: 12))
                            .foregroundColor(Color.theme.primaryTextColor)
                    }
                    .padding(4)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
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
                name: "Home",
                selectedTab: $selected
            )
            .frame(width: 60, height: 60)
            .padding()
            .background(Color(.systemBackground))
        }
    }
    return PreviewWrapper()
}
