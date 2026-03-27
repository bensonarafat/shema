//
//  SignInSheet.swift
//  Shema
//
//  Created by Benson Arafat on 25/03/2026.
//

import SwiftUI


struct SignInSheet: View {
    @EnvironmentObject var router : AppRouter
    @EnvironmentObject var authManager: AuthManager
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack (spacing: 20) {
            
            VStack (spacing: 0) {
                Text("Sign in to continue")
                    .font(.appDisplay)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, 12)
                
                Divider()
                    .background(.black)
                
            }
           
            VStack(spacing: 15) {
                SocialButton(
                    title: "Continue with Apple",
                    icon: "apple.logo",
                    bgColor: .black,
                    textColor: .white
                ) {
                    
                }
                
                SocialButton(
                    title: "Continue with Google",
                    assetIcon: "google",
                    bgColor: .white,
                    textColor: .black
                ) {
                    
                }
                
                SocialButton(
                    title: "Continue with email",
                    icon: "envelope.fill",
                    bgColor: .white,
                    textColor: .black
                ) {
                   dismiss()
                   DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                       authManager.appState = .auth
                       router.push(AppRoute.login)
                   }
                
                }
            
            }.padding(.horizontal)
            
            TermsText()
        }
        
       }
    
  
}
#Preview {
    SignInSheet()
        .environmentObject(AppRouter())
        .environmentObject(AuthManager())
}
