//
//  LocalScheduleView.swift
//  Shema
//
//  Created by Benson Arafat on 06/01/2026.
//

import SwiftUI

struct LockScheduleView: View {
    @StateObject private var settingsViewModel = SettingsViewModel()
    @EnvironmentObject private var nav: NavigationManager
    @State private var showCustomTimePicker: Bool = false
    @State private var errorMessage = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        
        ZStack {
            Color.theme.backgroundColor
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack(alignment: .leading, spacing: 16) {
                    ForEach (lockTimes, id: \.self) { time in
                        Button {
                            settingsViewModel.selectedReadTime = time
                            showCustomTimePicker = false
                        } label: {
                            Text(time)
                               .font(.fontNunitoBold(size: 16))
                               .foregroundColor(
                                settingsViewModel.selectedReadTime == time
                                 ? Color.theme.secondaryTextColor
                                 : Color.theme.primaryTextColor
                               )
                               .padding()
                               .frame(maxWidth: .infinity,)
                               .overlay (
                                   RoundedRectangle(cornerRadius: 8)
                                       .stroke(
                                        settingsViewModel.selectedReadTime == time ? Color.theme.secondaryColor :
                                        Color.theme.surfaceColor, lineWidth:
                                            settingsViewModel.selectedReadTime == time ? 1 :
                                            1)
                               )
                        }
                     
                        
                    }
                }
                
                Button {
                    showCustomTimePicker.toggle()
                    if showCustomTimePicker {
                        settingsViewModel.selectedReadTime = "Custom"
                    }
                } label: {
                    HStack {
                        Text(showCustomTimePicker ? formatTime(settingsViewModel.customTime) : "Custom time")
                            .font(.fontNunitoBold(size: 16))
                            .foregroundColor(
                                settingsViewModel.selectedReadTime  == "Custom"
                                ? Color.theme.primaryTextColor
                                : Color.theme.secondaryTextColor
                            )
                        Spacer()
                        
                        Image(systemName: showCustomTimePicker ? "chevron.up" : "chevron.down" )
                            .foregroundColor(
                                settingsViewModel.selectedReadTime == "Custom"
                                ? Color.theme.primaryTextColor
                                : Color.theme.secondaryTextColor
                            )
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .overlay {
                        RoundedRectangle (cornerRadius: 8)
                            .stroke(
                                settingsViewModel.selectedReadTime == "Custom"
                                ? Color.theme.secondaryColor
                                : Color.theme.surfaceColor,
                                lineWidth: settingsViewModel.selectedReadTime == "Custom" ? 2 : 1
                            )
                    }
                }
                
                if showCustomTimePicker {
                    DatePicker ("", selection: $settingsViewModel.customTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        .background(Color.theme.surfaceColor.opacity(0.3))
                        .cornerRadius(8)
                }
                
                Spacer()
                
                PrimaryButton(title: "Update",
                              backgroundColor: settingsViewModel.selectedReadTime != nil ? Color.theme.secondaryColor : Color.theme.surfaceColor,
                              foregroundColor : settingsViewModel.selectedReadTime != nil ? Color.black : Color.theme.disabledTextColor
                ) {
                   
                    guard settingsViewModel.selectedReadTime != nil else {
                        showAlert = true
                        errorMessage = "You need to select a time to continue"
                        return
                    }
                    Task {
                        if settingsViewModel.selectedReadTime == "Custom" {
                           await settingsViewModel.setReadTime(time: formatTime(settingsViewModel.customTime))
                        } else {
                          await  settingsViewModel.setReadTime(time: settingsViewModel.selectedReadTime!)
                        }
                    }
                    
                    nav.pop()
                }
                .disabled(settingsViewModel.selectedReadTime == nil)
            } .padding()
        }
        .navigationTitle("Lock Schedule")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Error", isPresented: $showAlert) {
            Button ("OK", role: .cancel){ }
        } message: {
            Text(errorMessage)
        }
    }
    
    func formatTime (_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
}

#Preview {
    var nav = NavigationManager()
    LockScheduleView()
        .environmentObject(nav)
}
