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
    @EnvironmentObject var scriptureService: ScriptureService
    var body: some View {
        
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            VStack (spacing: 16) {
                HomeTopHeader()
                ScrollView (showsIndicators: false) {
                    VStack(alignment: .leading) {
                        StreakCalendar()
                            .padding(.horizontal)
                        // Greating
                        Greating(viewModel: homeViewModel)
                        // Daily Verses
                        DailyVerse()
//                        // Bible Verses by Theme
//                        BibleVersesByTheme()
                         //Badge
                        BadgeGridView()
                    }
                }
                .onAppear {
                    Task {
                        await scriptureService.getScripture()
                    }
                }
                
            }
            
        }
    
    }
}

#Preview {
    let vm = BibleViewModel()
    let scriptureService = ScriptureService()
    HomeView()
        .environmentObject(vm)
        .environmentObject(scriptureService)
}


