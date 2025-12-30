//
//  SelectAppsPage.swift
//  Shema
//
//  Created by Benson Arafat on 30/12/2025.
//

import SwiftUI
import FamilyControls
import ManagedSettings

struct SelectAppsPage: View {
    var onPressed: () -> Void
    @EnvironmentObject var onboardingViewModel: OnboardingViewModel
    @EnvironmentObject var familyControlViewModel: FamilyControlViewModel
    @State var selection = FamilyActivitySelection()
    @State private var blockedApps: Set<ApplicationToken> = []
    @State private var blockedCategories: Set<ActivityCategoryToken> = []
    @State private var isAppCatSelected : Bool = false
    
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            VStack {
                VStack(spacing: 8) {
                    Text("Connect Shema to Screen Time, Securely.")
                        .font(.fontNunitoRegular(size: 25))
                        .lineSpacing(1.5)
                    
                    Text("To analyse your Screen Time on this iPhone Sheme will need your permission.")
                        .font(.fontNunitoRegular(size: 14))
                }
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
                .padding(.bottom, 40)
                
                
                Spacer()
                
                if isAppCatSelected {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        if blockedApps.isEmpty && blockedCategories.isEmpty {
                            Text("\(blockedApps.count) apps selected and \(blockedCategories.count) categories selected")
                                .foregroundColor(.green)
                        } else if (blockedApps.count != 0 ) {
                            Text("\(blockedApps.count) apps selected")
                                .foregroundColor(.green)
                        } else if (blockedCategories.count != 0) {
                            Text("\(blockedCategories.count) categories selected")
                                .foregroundColor(.green)
                        }
                        
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
                    
                }
                if !isAppCatSelected {
                    _appPickerButton()
                }else {
                    _continueButton()
                }
            }
        }
    }
    
    func _continueButton() -> some View {
        Button {
            if isAppCatSelected {
                onboardingViewModel.completeOnboarding()
//                nav.popToRoot()
//                nav.push(AppDestination.tabs)
                
            }
        } label : {
            HStack(spacing: 20) {
                
                Text("Continue")
                    .font(.fontNunitoRegular(size: 20))
                   
                Image(systemName: "arrow.right.circle.fill")
                    .foregroundColor(.black )
                    .font(.system(size: 24))
            }
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 25)
            .background(.white)
            .cornerRadius(20)
            .padding(.horizontal, 25)
        }
    }
    
    func _appPickerButton () -> some View {
        Button {
            
            guard familyControlViewModel.appBlockingService.isAuthorized else {
                print("Permission is required to access app list")
                return
            }
            familyControlViewModel.showingAppPicker = true
            
        } label: {
            
            HStack (spacing: 20) {
                
                Image(systemName: "plus")
                    .foregroundColor( .black)
                    .font(.system(size: 24))
                
                Text("Select Apps to limit")
                    .font(.fontNunitoRegular(size: 20))
                
                
            }
            .foregroundColor(.black )
            .frame(maxWidth: .infinity)
            .padding(.vertical, 25)
            .background(.white)
            .cornerRadius(20)
            .padding(.horizontal, 25)
            
        }.familyActivityPicker(isPresented: $familyControlViewModel.showingAppPicker, selection: $selection
        ).onChange(of: selection) { oldValue, newValue in
            familyControlViewModel.appBlockingService.saveBlockedApps(newValue)
            blockedApps = familyControlViewModel.appBlockingService.blockedApps
            blockedCategories = familyControlViewModel.appBlockingService.blockedCategories
            isAppCatSelected = !blockedApps.isEmpty || !blockedCategories.isEmpty
        }
    }
}

#Preview {
    let onboardingVM = OnboardingViewModel()
    let familyControlVM = FamilyControlViewModel()
    SelectAppsPage {
    }
    .environmentObject(onboardingVM)
    .environmentObject(familyControlVM)
}
