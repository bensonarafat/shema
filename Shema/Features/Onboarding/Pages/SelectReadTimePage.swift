//
//  SelectReadTimePage.swift
//  Shema
//
//  Created by Benson Arafat on 30/12/2025.
//

import SwiftUI



struct SelectReadTimePage: View {
    @EnvironmentObject private var onboardingViewModel: OnboardingViewModel
    @EnvironmentObject private var nav: NavigationManager
    @State private var selectedTime: String? = nil
    @State private var showCustomTimePicker: Bool = false
    @State private var customTime: Date = Date()
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
                            selectedTime = time
                            showCustomTimePicker = false
                        } label: {
                            Text(time)
                               .font(.fontNunitoBold(size: 16))
                               .foregroundColor(
                                selectedTime == time
                                 ? Color.theme.secondaryTextColor
                                 : Color.theme.primaryTextColor
                               )
                               .padding()
                               .frame(maxWidth: .infinity,)
                               .overlay (
                                   RoundedRectangle(cornerRadius: 8)
                                       .stroke(
                                        selectedTime == time ? Color.theme.secondaryColor :
                                        Color.theme.surfaceColor, lineWidth:
                                            selectedTime == time ? 1 :
                                            1)
                               )
                        }
                     
                        
                    }
                }
                
                Button {
                    showCustomTimePicker.toggle()
                    if showCustomTimePicker {
                        selectedTime = "Custom"
                    }
                } label: {
                    HStack {
                        Text(showCustomTimePicker ? formatTime(customTime) : "Custom time")
                            .font(.fontNunitoBold(size: 16))
                            .foregroundColor(
                                selectedTime == "Custom"
                                ? Color.theme.primaryTextColor
                                : Color.theme.secondaryTextColor
                            )
                        Spacer()
                        
                        Image(systemName: showCustomTimePicker ? "chevron.up" : "chevron.down" )
                            .foregroundColor(
                                selectedTime == "Custom"
                                ? Color.theme.primaryTextColor
                                : Color.theme.secondaryTextColor
                            )
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .overlay {
                        RoundedRectangle (cornerRadius: 8)
                            .stroke(
                                selectedTime == "Custom"
                                ? Color.theme.secondaryColor
                                : Color.theme.surfaceColor,
                                lineWidth: selectedTime == "Custom" ? 2 : 1
                            )
                    }
                }
                
                if showCustomTimePicker {
                    DatePicker ("", selection: $customTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        .background(Color.theme.surfaceColor.opacity(0.3))
                        .cornerRadius(8)
                }
                
                Spacer()
                
                PrimaryButton(title: "Continue",
                              backgroundColor: selectedTime != nil ? Color.theme.secondaryColor : Color.theme.surfaceColor,
                              foregroundColor : selectedTime != nil ? Color.black : Color.theme.disabledTextColor
                ) {
                   
                    guard selectedTime != nil else {
                        showAlert = true
                        errorMessage = "You need to select a time to continue"
                        return
                    }
                    if selectedTime == "Custom" {
                        onboardingViewModel.setReadTime(time: formatTime(customTime))
                    } else {
                        onboardingViewModel.setReadTime(time: selectedTime!)
                    }
                    
                    onboardingViewModel.completeOnboarding()
                    nav.popToRoot()
                    nav.push(AppDestination.registerNowLater)
                }
                .disabled(selectedTime == nil)
            }
        }
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
    var vm = OnboardingViewModel()
    var nav = NavigationManager()
    SelectReadTimePage()
        .environmentObject(vm)
        .environmentObject(nav)
}
