//
//  ScreenTimePermissionView.swift
//  Shema
//
//  Created by Benson Arafat on 29/10/2025.
//

import SwiftUI

struct ScreenTimePermissionView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State private var didGrantNotifications = false
    @EnvironmentObject var viewModel : BibleLockViewModel;
    @State private var showingError = false
    @State private var errorMessage = ""
    
    @EnvironmentObject var nav: NavigationManager
    
    var body: some View {
            VStack {
                VStack(spacing: 8) {
                    Text("Connect Shema to Screen Time, Securely.")
                        .font(.fontNotoSansBlack(size: 25))
                        .lineSpacing(1.5)
                    
                    Text("To analyse your Screen Time on this iPhone Sheme will need your permission.")
                        .font(.fontNotoSansRegular(size: 14))
                }
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
                .padding(.bottom, 40)
                
                
                VStack {
                    if colorScheme == .dark {
                        _popupImage("access_screen_time_dark")
                    } else {
                        _popupImage("access_screen_time_light")
                    }
                }
                .onTapGesture {
                    Task {
                        do {
                            try await viewModel.appBlockingService.requestAuthorization()
                            if viewModel.appBlockingService.isAuthorized {
                                nav.push(AppDestination.selectApps)
                            }else {
                                errorMessage = "Screen Time permission denied"
                                showingError = true
                            }
                        }catch {
                            errorMessage = "Failed to get permission: \(error.localizedDescription)"
                            showingError = true
                        }
                    }
                }
                
                
                Spacer()
                
                VStack (spacing: 8) {
                    Text("Yout senstive data is protected by Apple and never leaves your device.")
                        .font(.fontNotoSansRegular(size: 15))
                    Text("Learn More")
                        .font(.fontNotoSansSemiBold(size: 16))
                }
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                
            }
            .navigationBarBackButtonHidden(true)
            .padding()
            .alert("Error", isPresented: $showingError) {
                Button ("OK", role: .cancel) {}
            } message: {
                Text(errorMessage)
     
            }
    }
    
    func _popupImage(_ source: String) -> some View {
        Image(source).resizable().scaledToFit().padding()
    }
}

#Preview {
    var nav = NavigationManager();
    ScreenTimePermissionView()
        .environmentObject(nav);
}
