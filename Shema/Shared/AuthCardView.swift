//
//  AuthCardView.swift
//  Shema
//
//  Created by Benson Arafat on 05/01/2026.
//

import SwiftUI

struct AuthCardView: View {
    var title: String
    @EnvironmentObject var nav: NavigationManager
    
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            VStack (spacing: 16) {
                Text(title)
                    .foregroundColor(Color.theme.secondaryTextColor)
                    .font(.fontNunitoBold(size: 18))
                    .multilineTextAlignment(.center)
                
                PrimaryButton (title: "create a profile", backgroundColor: Color.theme.macaw, foregroundColor: Color.black) {
                    nav.push(AppDestination.register)
                }
                
                SecondaryButton(title: "Sign in", foregroundColor: Color.theme.macaw) {
                    nav.push(AppDestination.login)
                }
            }.padding()
        }
        
    }
}

#Preview {
    let nav = NavigationManager()
    AuthCardView(title: "You need a profile to use Leaderboards")
        .environmentObject(nav)
}
