//
//  BadgesView.swift
//  Shema
//
//  Created by Benson Arafat on 03/11/2025.
//

import SwiftUI

struct BadgesView: View {
    @EnvironmentObject var nav: NavigationManager
    @EnvironmentObject var viewModel: BadgeViewModel;
    let items = [GridItem(.adaptive(minimum: 120), spacing: 16)]
    
    
    var body: some View {
        ScrollView {
            LazyVGrid (columns: items, spacing: 20) {
                ForEach(viewModel.allBadges)  { badge in
                    VStack {
                        Image(badge.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .opacity(viewModel.isBadgeCompleted(badgeId: badge.id ) ? 1 : 0.5)
                            .grayscale(viewModel.isBadgeCompleted(badgeId: badge.id ) ? 0: 1)
                    }
                }
            }
        }
        .background(Color.theme.backgroundColor)
        .navigationTitle("Badges")
    }
}

#Preview {
    let nav = NavigationManager()
    let vm = BadgeViewModel()
    return BadgesView()
        .environmentObject(vm)
        .environmentObject(nav)
}
