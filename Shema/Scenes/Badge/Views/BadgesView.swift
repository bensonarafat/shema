//
//  BadgesView.swift
//  Shema
//
//  Created by Benson Arafat on 03/11/2025.
//

import SwiftUI

struct BadgesView: View {
    @EnvironmentObject var nav: NavigationManager
    @ObservedObject var viewModel: BadgeViewModel;
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
                            .opacity(viewModel.isUnlocked(badge) ? 1 : 0.5)
                            .grayscale(viewModel.isUnlocked(badge) ? 0: 1)
                    }
                }
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Badges")
    }
}

#Preview {
    let nav = NavigationManager()
    @StateObject var vm = BadgeViewModel()
    return BadgesView(viewModel: vm)
        .environmentObject(nav)
}
