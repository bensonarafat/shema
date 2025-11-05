//
//  ContentView.swift
//  Shema
//
//  Created by Benson Arafat on 07/10/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var viewModel: BibleLockViewModel
    @EnvironmentObject var nav: NavigationManager
    
    var body: some View {
        NavigationStack (path: $nav.path){
            Group {
                if !viewModel.hasCompletedOnboarding {
                    WelcomeView()
                } else {
                    TabBarView()
                }
            }
            .navigationDestination(for: AppDestination.self) { destination in
                destinationView(for: destination)
            }
        }
    }

    
    @ViewBuilder
    private func destinationView (for destination: AppDestination) -> some View {
        switch destination {
        case .notifications:
            NotificationPermissionView()
        case .screenTime:
            ScreenTimePermissionView()
        case .welcome:
            WelcomeView()
        case .selectApps:
            SelectAppsView()
        case .bible:
            BibleReaderView()
        case .bookmarks:
            BookmarkView()
        case .home:
            HomeView()
        case .settings:
            SettingsView()
        case .tabs:
            TabBarView()
        case .badges:
            BadgesView(viewModel: BadgeViewModel())
        case .themeVerses:
            ThemeVersesView()
        case .focus(let focus):
            FocusView(focus: focus)
        }
    }
}

#Preview {
    let vm = BibleLockViewModel()
    ContentView().environmentObject(vm)
}
