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
//    var onPressed: () -> Void
//    @EnvironmentObject var onboardingViewModel: OnboardingViewModel
//    @EnvironmentObject var familyControlViewModel: FamilyControlViewModel
//    @EnvironmentObject private var nav: NavigationManager
//    @EnvironmentObject var scriptureService: ScriptureService
//    @State var selection = FamilyActivitySelection()
//    @State private var blockedApps: Set<ApplicationToken> = []
//    @State private var blockedCategories: Set<ActivityCategoryToken> = []
//    @State private var isAppCatSelected : Bool = false
//    @State private var errorMessage: String = ""
//    @State private var showError: Bool = false
    
    var body: some View {
//        ZStack {
//            Color.theme.backgroundColor
//                .ignoresSafeArea()
//            
//            VStack {
//                Spacer()
//                
//                VStack {
//                    Image("select_apps")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit )
//                        .padding(50)
//                    
//                }
//               
//            
//                Spacer()
//                
//                if isAppCatSelected {
//                    HStack {
//                        Image(systemName: "checkmark.circle.fill")
//                            .foregroundColor(.green)
//                        if blockedApps.isEmpty && blockedCategories.isEmpty {
//                            Text("\(blockedApps.count) apps selected and \(blockedCategories.count) categories selected")
//                                .foregroundColor(.green)
//                        } else if (blockedApps.count != 0 ) {
//                            Text("\(blockedApps.count) apps selected")
//                                .foregroundColor(.green)
//                        } else if (blockedCategories.count != 0) {
//                            Text("\(blockedCategories.count) categories selected")
//                                .foregroundColor(.green)
//                        }
//                        
//                    }
//                    .padding()
//                    .background(Color.green.opacity(0.1))
//                    .cornerRadius(10)
//                    .onTapGesture {
//                        showPicker()
//                    }
//                    
//                }
//
//                PrimaryButton(title: !isAppCatSelected ? "Select apps to limit" : "Continue") {
//                    if isAppCatSelected {
//                        // onboarding is complete
//                        onboardingViewModel.completeOnboarding()
//                        // First Lock all apps
//                        familyControlViewModel.appBlockingService.enableBlocking()
//                        // Navigate to today's scripture
//                        if (scriptureService.scripture != nil) {
//                            let scripture = scriptureService.scripture!
//                            var updatedScripture = scripture
//                            updatedScripture.fromOnboarding = true
//                            nav.push( AppDestination.scripture(updatedScripture))
//                        }else {
//                            nav.popToRoot()
//                            nav.push(AppDestination.registerNowLater(false))
//                        }
//                       
//                    } else {
//                        showPicker()
//                    }
//                }.familyActivityPicker(isPresented: $familyControlViewModel.showingAppPicker, selection: $selection
//                ).onChange(of: selection) { oldValue, newValue in
//                    familyControlViewModel.appBlockingService.saveBlockedApps(newValue)
//                    blockedApps = familyControlViewModel.appBlockingService.blockedApps
//                    blockedCategories = familyControlViewModel.appBlockingService.blockedCategories
//                    isAppCatSelected = !blockedApps.isEmpty || !blockedCategories.isEmpty
//                }
//            }
//        }
//        .alert("Error", isPresented: $showError) {
//            Button("Ok", role: .cancel) {}
//        }message : {
//            Text(errorMessage)
//        }
    }
    
    
//    func showPicker () {
//        guard familyControlViewModel.appBlockingService.isAuthorized else {
//            errorMessage = "Permission is required to access app list"
//            showError = true
//            return
//        }
//        familyControlViewModel.showingAppPicker = true
//    }
}

#Preview {
//    let onboardingVM = OnboardingViewModel()
//    let familyControlVM = FamilyControlViewModel()
//    var nav = NavigationManager()
    SelectAppsPage()
//    .environmentObject(onboardingVM)
//    .environmentObject(familyControlVM)
//    .environmentObject(nav)
}
