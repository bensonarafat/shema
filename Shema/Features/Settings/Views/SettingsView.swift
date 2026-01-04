//
//  SettingsView.swift
//  Shema
//
//  Created by Benson Arafat on 10/10/2025.
//

import SwiftUI
import FamilyControls

struct SettingsView: View {

    @EnvironmentObject var viewModel: FamilyControlViewModel
    @State private var selection: FamilyActivitySelection = .init()
    @Environment(\.dismiss) var dismiss
    @State private var reminderTime: Date = .init()
    @State private var showingAppPicker = false
     
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
                          
                        HStack {
                            Image("screen-time")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            Text("Apps & Categories")
                                .font(.fontNunitoBold(size: 16))
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        
                        Divider()
                            .background(Color.theme.surfaceColor)
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
                                Image(systemName: "chevron.right")
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
                            Image(systemName: "chevron.right")
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
                        
                        
                        Divider()
                            .background(Color.theme.surfaceColor)
                        
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
                    .padding()
                    .background(Color(hex: "1c2923"))
                    .cornerRadius(16)
                    
                    Text("Shema Version 1.0.0")
                        .foregroundColor(Color.theme.primaryTextColor)
                        .font(.fontNunitoRegular(size: 15))

                 
                }
                .padding()
                .foregroundColor(Color.theme.primaryTextColor)
                
            }
 
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)

    }
    
    func loadSavedSelection() {
        if let loadedSelection = viewModel.appBlockingService.loadBlockedApps() {
            selection = loadedSelection
        }
    }
}

#Preview {
    let vm = FamilyControlViewModel()
    SettingsView()
        .environmentObject(vm)
}
