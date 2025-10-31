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
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack (path: $path){
            Group {
                if !viewModel.hasCompletedOnboarding {
                    WelcomeView(path: $path)
                } else {
                    TabBarView(path: $path)
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
            NotificationPermissionView(path: $path)
        case .screenTime:
            ScreenTimePermissionView(path: $path)
        case .welcome:
            WelcomeView(path: $path)
        case .selectApps:
            SelectAppsView(path: $path)
        case .selectBibleVerse:
            SelectAppsView(path: $path)
        case .bible:
            BibleReaderView()
        case .bookmarks:
            BookmarkView()
        case .home:
            HomeView()
        case .settings:
            SettingsView()
        case .tabs:
            TabBarView(path: $path)
        }
    }
}

#Preview {
    let vm = BibleLockViewModel()
    ContentView().environmentObject(vm)
}
