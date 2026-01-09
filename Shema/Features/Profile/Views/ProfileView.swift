//
//  ProfileView.swift
//  Shema
//
//  Created by Benson Arafat on 03/01/2026.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var networkMonitor: NetworkMonitor
    
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            if networkMonitor.isConnected {
                if authViewModel.isAuthenticated {
                    ProfilePage()
                } else {
                    AuthCardView(title: "You need a profile to access account")
                }
            } else {
                ZStack {
                    NetworkCardView(title: "Profile")
                }
            }
            
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
   
    }
}

#Preview {
    let authViewModel = AuthViewModel()
    let networkMonitor = NetworkMonitor.shared

    ProfileView()
        .environmentObject(authViewModel)
        .environmentObject(networkMonitor)
}
