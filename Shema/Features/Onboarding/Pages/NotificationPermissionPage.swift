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
    
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            VStack {
                
                VStack(spacing: 6) {
                    Text("Now, let's set our hearts on the Word.")
                        .font(.fontNunitoRegular(size: 16))
                    
                    Text("Get notified to continue your Bible journey.")
                        .font(.fontNunitoRegular(size: 28))
                        .lineSpacing(0.5)
                    
                    
                    Text("We'll nudge you when it's time to reconnect with Scripture and draw closer to Him.")
                        .font(.fontNunitoRegular(size: 14))
                }
                .foregroundColor(.theme.primaryTextColor)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
                .padding(.bottom, 40)
                
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
    }
    
    
    func grantNotification ()  {
        Task {
            let granted = await NotificationService.shared.requestAuthorization()
            didGrantNotifications = granted
            if granted {
                onPressed()
            } else{
                
            }
        }
    }

}

#Preview {
    NotificationPermissionPage {
        
    }
}
