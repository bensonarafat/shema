//
//  SettingsView.swift
//  Shema
//
//  Created by Benson Arafat on 10/10/2025.
//

import SwiftUI
import FamilyControls
import ManagedSettings

struct SettingsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var familyControlViewModel: FamilyControlViewModel
    @StateObject private var settingsViewModel = SettingsViewModel()
    @State var selection = FamilyActivitySelection()
    @State private var blockedApps: Set<ApplicationToken> = []
    @State private var blockedCategories: Set<ActivityCategoryToken> = []
    @EnvironmentObject var nav: NavigationManager
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @EnvironmentObject var viewModel: FamilyControlViewModel
    @Environment(\.dismiss) var dismiss
    @State private var showingAppPicker = false
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
     
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            ScrollView (showsIndicators: false){
                VStack (spacing: 16)  {
                    
                    VStack (alignment: .leading, spacing: 16) {
                        Text("Time Control")
                            .textCase(.uppercase)
                            .font(.fontNunitoBlack(size: 15))
                            .foregroundColor(Color.gray)
                        
                        Button {
                            showPicker()
                        } label : {
                            HStack {
                                Image("screen-time")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                Text("Apps & Categories")
                                    .font(.fontNunitoBold(size: 16))
                                Spacer()
                                HStack {
                                    Text("\(familyControlViewModel.appBlockingService.blockedApps.count + familyControlViewModel.appBlockingService.blockedCategories.count)")
                                    Image(systemName: "chevron.right")
                                }.familyActivityPicker(isPresented: $familyControlViewModel.showingAppPicker, selection: $selection
                                )
                                .onChange(of: selection) { oldValue, newValue in
                                    familyControlViewModel.appBlockingService.saveBlockedApps(newValue)
                                    blockedApps = familyControlViewModel.appBlockingService.blockedApps
                                    blockedCategories = familyControlViewModel.appBlockingService.blockedCategories
                                }
                                
                            }
                        }
                        
                        Divider()
                            .background(Color.theme.surfaceColor)
                        Button {
                            nav.push(AppDestination.lockSchedule)
                        } label : {
                            HStack {
                                Image("schedule")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                
                                Text("Lock Schedule")
                                    .font(.fontNunitoBold(size: 16))
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                        }
                      
                        
                        Divider()
                            .background(Color.theme.surfaceColor)
                            
                            HStack {
                                Image("unlock")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                
                                Text("Emergency Unlock")
                                    .font(.fontNunitoBold(size: 16))
                                Spacer()
                                Toggle("", isOn: $familyControlViewModel.appBlockingService.isBlockingActive)
                                    .tint(Color.theme.primaryColor)
                            }
                            .onChange(of: familyControlViewModel.appBlockingService.isBlockingActive) { oldValue, newValue in
                                if newValue {
                                    familyControlViewModel.appBlockingService.enableBlocking()
                                } else {
                                    familyControlViewModel.appBlockingService.disableBlocking()
                                }
                                
                            }
                       
                    }
                    .padding()
                    .background(Color(hex: "1c2923"))
                    .cornerRadius(16)
                    
                    VStack (alignment: .leading, spacing: 16) {
                        Text("Reading Preferences")
                              .textCase(.uppercase)
                              .font(.fontNunitoBlack(size: 15))
                              .foregroundColor(Color.gray)
                          
                    
                        HStack {
                            Image("bible")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)

                            Text("Bible Translation")
                                .font(.fontNunitoBold(size: 16))
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                       
                    }
                    .padding()
                    .background(Color(hex: "1c2923"))
                    .cornerRadius(16)

                    
                    VStack (alignment: .leading, spacing: 16) {
                        Text("Notifications")
                              .textCase(.uppercase)
                              .font(.fontNunitoBlack(size: 15))
                              .foregroundColor(Color.gray)
                          
                    
                        HStack {
                            Image("bell")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)

                            Text("Pop-up Notifications")
                                .font(.fontNunitoBold(size: 16))
                            Spacer()
                            Toggle("", isOn: $settingsViewModel.pushNotification)
                                .tint(Color.theme.primaryColor)
                        }
                       
                    }
                    .padding()
                    .background(Color(hex: "1c2923"))
                    .cornerRadius(16)
                    
                    
                    VStack (alignment: .leading, spacing: 16) {
                        Text("Others")
                              .textCase(.uppercase)
                              .font(.fontNunitoBlack(size: 15))
                              .foregroundColor(Color.gray)
                          
                    
                        HStack {
                            Image("support")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)

                            Text("Support")
                                .font(.fontNunitoBold(size: 16))
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        
                        
                        Divider()
                            .background(Color.theme.surfaceColor)
                        
                        HStack {
                            Image("faq")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)

                            Text("FAQ")
                                .font(.fontNunitoBold(size: 16))
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        
                        Divider()
                            .background(Color.theme.surfaceColor)
                        
                        HStack {
                            Image("privacy")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)

                            Text("Privacy Policy")
                                .font(.fontNunitoBold(size: 16))
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                       
                    }
                    .padding()
                    .background(Color(hex: "1c2923"))
                    .cornerRadius(16)

                    
                    if isAuthAndNetworkReady() {
                            VStack (alignment: .leading, spacing: 16) {
                                Text("Account")
                                      .textCase(.uppercase)
                                      .font(.fontNunitoBlack(size: 15))
                                      .foregroundColor(Color.gray)
                                  
                            
                                HStack {
                                    Image("logout")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)

                                    Text("Log Out")
                                        .font(.fontNunitoBold(size: 16))
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                                .onTapGesture {
                                    authViewModel.logout()
                                    nav.popToRoot()
                                    nav.push(AppDestination.welcome)
                                }
                                
                                
                                Divider()
                                    .background(Color.theme.surfaceColor)
                                
                                Button {
                                    Task {
                                        await authViewModel.deleteAccount()
                                    }
                                } label : {
                                    HStack {
                                        Image("delete-account")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)

                                        Text("Delete Account")
                                            .font(.fontNunitoBold(size: 16))
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                    }
                                }
                             
                                
                               
                            }
                            .padding()
                            .background(Color(hex: "1c2923"))
                            .cornerRadius(16)
                        }
                

                    
                    Text("Shema Version 1.0.0")
                        .foregroundColor(Color.theme.primaryTextColor)
                        .font(.fontNunitoRegular(size: 15))

                 
                }
                .padding()
                .foregroundColor(Color.theme.primaryTextColor)
                
            }
            
            if authViewModel.isLoading {
                OverlayLoading()
                    .transition(.opacity)
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: settingsViewModel.pushNotification) { oldValue, newValue in
            Task {
                await settingsViewModel.updateNotificationSettings(newValue)
            }
            
        }
        .alert("Error", isPresented: $showError) {
            Button("Ok", role: .cancel) {}
        }message : {
            Text(errorMessage)
        }

    }
    
    func loadSavedSelection() {
        if let loadedSelection = viewModel.appBlockingService.loadBlockedApps() {
            selection = loadedSelection
        }
    }
    
    func isAuthAndNetworkReady() -> Bool {
        return authViewModel.isAuthenticated && networkMonitor.isConnected
    }
    
    func showPicker () {
        guard familyControlViewModel.appBlockingService.isAuthorized else {
            errorMessage = "Permission is required to access app list"
            showError = true
            return
        }
        familyControlViewModel.showingAppPicker = true
    }
}

#Preview {
    let vm = FamilyControlViewModel()
    let networkMonitor = NetworkMonitor.shared
    let authViewModel = AuthViewModel()
    let nav = NavigationManager()
    let familyControlViewModel = FamilyControlViewModel()
    SettingsView()
        .environmentObject(vm)
        .environmentObject(authViewModel)
        .environmentObject(networkMonitor)
        .environmentObject(nav)
        .environmentObject(familyControlViewModel)
}
