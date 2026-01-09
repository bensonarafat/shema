//
//  LevelView.swift
//  Shema
//
//  Created by Benson Arafat on 03/01/2026.
//

import SwiftUI

struct LevelView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var networkMonitor: NetworkMonitor
    
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            if networkMonitor.isConnected {
                if authViewModel.isAuthenticated {
                    LevelPage()
                } else {
                    AuthCardView(title: "You need a profile to use Leaderboards")
                }
            } else {
                ZStack {
                    NetworkCardView(title: "Leaderboards")
                }
            }
        }
    }
}

#Preview {
    let networkMonitor = NetworkMonitor.shared
    let authViewModel = AuthViewModel()
    LevelView()
        .environmentObject(networkMonitor)
        .environmentObject(authViewModel)
}
