//
//  NotificationPermissionView.swift
//  Shema
//
//  Created by Benson Arafat on 29/10/2025.
//

import SwiftUI


struct NotificationPermissionView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State private var didGrantNotifications = false
    @EnvironmentObject var nav: NavigationManager
    
    var body: some View {
        VStack {
            
            VStack(spacing: 6) {
                Text("Now, let's set our hearts on the Word.")
                    .font(.fontNotoSansBold(size: 16))
                
                Text("Get notified to continue your Bible journey.")
                    .font(.fontNotoSansBlack(size: 28))
                    .lineSpacing(0.5)
                
                
                Text("We'll nudge you when it's time to reconnect with Scripture and draw closer to Him.")
                    .font(.fontNotoSansMedium(size: 14))
            }
            .multilineTextAlignment(.center)
            .padding(.horizontal, 16)
            .padding(.bottom, 40)
            
            
            VStack {
                if colorScheme == .dark {
                    _popupImage("push_notification_dark")
                } else {
                    _popupImage("push_notification_light")
                }
            }
            .onTapGesture {
                Task {
                    let granted = await NotificationService.shared.requestAuthorization()
                    
                    didGrantNotifications = granted
                    if granted {
                        nav.push(AppDestination.screenTime)
                    } else {
                        // Handle denial (show alert or proceed accordingly)
                    }
                    
                }
            }
            
            Spacer()
            
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }

    
    
    func _popupImage(_ source: String) -> some View {
        Image(source).resizable().scaledToFit().padding()
    }
}

#Preview {
    var nav = NavigationManager()
    NotificationPermissionView()
        .environmentObject(nav);
}
