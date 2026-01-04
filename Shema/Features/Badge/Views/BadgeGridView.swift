//
//  BadgeGridView.swift
//  Shema
//
//  Created by Benson Arafat on 03/11/2025.
//

import SwiftUI

struct BadgeGridView: View {
    @EnvironmentObject var nav : NavigationManager
    @StateObject private var viewModel =  BadgeViewModel()
    
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
                ForEach (viewModel.topSixBadges()) { badge in
                    VStack {
                        Image(badge.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 75, height: 75)
                            .opacity(viewModel.isUnlocked(badge) ? 1 : 0.5)
                            .grayscale(viewModel.isUnlocked(badge) ? 0: 1)
                    }
                    
                }
            }
        }
        .padding(.vertical)
    }
}

#Preview {
    let nav = NavigationManager()
    BadgeGridView()
        .environmentObject(nav);
}
