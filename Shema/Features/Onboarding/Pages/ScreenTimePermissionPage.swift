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
                .foregroundColor(.theme.primaryTextColor)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
                .padding(.bottom, 40)
                
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
                
                VStack (spacing: 8) {
                    Text("Yout senstive data is protected by Apple and never leaves your device.")
                        .font(.fontNunitoRegular(size: 15))
                    Text("Learn More")
                        .font(.fontNunitoRegular(size: 16))
                }
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                
                PrimaryButton(title: "give access to app screen time") {
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
        Task {
            do {
                try await viewModel.appBlockingService.requestAuthorization()
                if viewModel.appBlockingService.isAuthorized {
                    onPressed()
                }else {
                    errorMessage = "Screen Time permission denied"
                    showingError = true
                }
            } catch {
                errorMessage = "Failed to get permission: \(error.localizedDescription)"
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
