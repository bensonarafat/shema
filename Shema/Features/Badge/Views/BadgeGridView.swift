//
//  BadgeGridView.swift
//  Shema
//
//  Created by Benson Arafat on 03/11/2025.
//

import SwiftUI

struct BadgeGridView: View {
    @EnvironmentObject var nav : NavigationManager
    @EnvironmentObject var badgeViewModel: BadgeViewModel
    
    let columns = [GridItem(.adaptive(minimum: 120), spacing: 16)]
    
    var body:  some View {
        VStack {
            HStack {
                Text("Badges")
                    .textCase(.uppercase)
                    .font(.fontNunitoBlack(size: 16))
                    .foregroundColor(.gray)

                Spacer()
                Button (action : {
                    nav.push(AppDestination.badges)
                } ){
                    Image(systemName: "chevron.forward")
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal)
            
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach (badgeViewModel.topNineBadges()) { badge in
                    VStack {
                        Image(badge.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 75, height: 75)
                            .opacity(badgeViewModel.isBadgeCompleted(badgeId: badge.id) ? 1 : 0.5)
                            .grayscale(badgeViewModel.isBadgeCompleted(badgeId: badge.id) ? 0: 1)
                    }
                    
                }
            }
        }
        .padding(.vertical)
    }
}

#Preview {
    let nav = NavigationManager()
    let badgeViewModel = BadgeViewModel()
    BadgeGridView()
        .environmentObject(nav)
        .environmentObject(badgeViewModel);
}
