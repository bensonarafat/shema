//
//  ScreenTimePermissionPage.swift
//  Shema
//
//  Created by Benson Arafat on 30/12/2025.
//

import SwiftUI

struct ScreenTimePermissionPage: View {
    var onPressed: () -> Void
    @State private var didGrantNotifications = false
    @EnvironmentObject var viewModel : FamilyControlViewModel;
    @State private var showingError = false
    @State private var errorMessage = ""
    @State private var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack {
                    Image("screen_time")
                        .resizable()
                        .aspectRatio(contentMode: .fit )
                        .padding(50)
                    
                }
                .onTapGesture {
                    grantAccessScreenTime()
                }
                
                
                Spacer()
                
                Text("Yout senstive data is protected by Apple and never leaves your device. [Learn More](https://www.apple.com/privacy)")
                    .font(.fontNunitoRegular(size: 14))
                    .foregroundColor(.theme.secondaryTextColor)
                    .tint(.theme.secondaryTextColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                PrimaryButton(title:
                                isLoading
                                    ? "requesting permission..."
                                    : "give access to app screen time") {
                    
                    if isLoading {
                        return
                    }
                    grantAccessScreenTime()
                }
              
                

            }
            .alert("Error", isPresented: $showingError) {
                Button ("OK", role: .cancel) {}
            } message: {
                Text(errorMessage)
     
            }
        }
    }
    
    func grantAccessScreenTime () {
        isLoading = true
        Task {
            await viewModel.appBlockingService.requestAuthorization()
            isLoading = false
            if viewModel.appBlockingService.isAuthorized {
                onPressed()
            }else {
                isLoading = false
                errorMessage = "Permission is not granted"
                showingError = true
            }
        }
    }
}

#Preview {
    let vm  = FamilyControlViewModel()
    ScreenTimePermissionPage{
        
    }.environmentObject(vm)
}
