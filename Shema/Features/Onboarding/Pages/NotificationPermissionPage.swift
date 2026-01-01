//
//  NotificationPermissionPage.swift
//  Shema
//
//  Created by Benson Arafat on 30/12/2025.
//

import SwiftUI

struct NotificationPermissionPage: View {
    
    var onPressed: () -> Void
    @State private var didGrantNotifications = false
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                Image("notification")
                    .resizable()
                    .aspectRatio(contentMode: .fit )
                    .padding(50)
                
                .onTapGesture {
                    grantNotification()
                }
                
                Spacer()
                
                PrimaryButton(title: "remind me to study the bible") {
                    grantNotification()
                }
            }
        }
        .alert("Error", isPresented: $showError) {
            Button("Ok", role: .cancel){}
        } message : {
            Text(errorMessage)
        }
    }
    
    
    func grantNotification ()  {
        Task {
            let granted = await NotificationService.shared.requestAuthorization()
            didGrantNotifications = granted
            if granted {
                onPressed()
            } else{
                errorMessage = "Notification permission declined"
                showError = true
            }
        }
    }

}

#Preview {
    NotificationPermissionPage {
        
    }
}
