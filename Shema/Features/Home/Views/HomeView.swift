//
//  HomeView.swift
//  Shema
//
//  Created by Benson Arafat on 10/10/2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: BibleViewModel
    @StateObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            VStack (spacing: 16) {
                HomeTopHeader()
                    .padding(.leading, 8)
                    .padding(.trailing, 8)
                Divider()
                ScrollView {
                    VStack(alignment: .leading) {
                        // Greating
                        Greating(viewModel: homeViewModel)
                        // Daily Verses
                        DailyVerse()
                        // Bible Verses by Theme
                        BibleVersesByTheme()
                        // Badge
                        BadgeGridView()
                    }
                }
                
            }
            
        }
       
    }
}

#Preview {
    let vm = BibleViewModel()
    HomeView().environmentObject(vm)
}

