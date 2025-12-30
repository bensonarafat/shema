//
//  LoginView.swift
//  Shema
//
//  Created by Benson Arafat on 30/12/2025.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @FocusState private var emailIsFocused: Bool
    
    @State private var password = ""
    @FocusState private var passwordIsFocused: Bool
    
    var body: some View {
        VStack {
            
            // Login Form
            VStack (alignment: .leading, spacing: 32) {
                
                VStack  (alignment: .leading, spacing: 8) {
                    Text("Welcome back!")
                        .font(.fontNunitoExtraBold(size: 20))
                        .fontWeight(.black)
                        .foregroundColor(.theme.primaryTextColor)
                    Text("Login to your account")
                        .font(.fontNunitoRegular(size: 16))
                        .fontWeight(.heavy)
                        .foregroundColor(.theme.primaryTextColor)
                }
             
                VStack (spacing: 16) {
                    ZStack (alignment: .leading) {
                        if email.isEmpty {
                            Text("Email")
                                .foregroundColor(.theme.secondaryTextColor)
                        }
                        TextField("", text: $email)
                            .foregroundColor(Color.theme.secondaryTextColor)
                    }
                    .padding()
                    .background(Color("202e36"))
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(
                                emailIsFocused ? Color.theme.secondaryColor :
                                Color.theme.surfaceColor, lineWidth: 1)
                    )
                    .focused($emailIsFocused)
                    
                    ZStack (alignment: .leading) {
                        if password.isEmpty {
                            Text("Password")
                                .foregroundColor(.theme.secondaryTextColor)
                        }
                        SecureField("", text: $password)
                            .foregroundColor(Color.theme.secondaryTextColor)
                    }
                        .padding()
                        .background(Color("202e36"))
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(
                                    passwordIsFocused ? Color.theme.secondaryColor :
                                    Color.theme.surfaceColor, lineWidth: 1)
                        )
                        .focused($passwordIsFocused)
                    
                    
                    PrimaryButton(title: "Login") {
                       
                    }

                }
               
                
                
              
            }
            
            Spacer()
            VStack (spacing: 16) {
                
                SecondaryButton(title: "sign up with google", customImage: "google" ) {
                    
                }
                SecondaryButton(title: "sign up with apple", icon: "apple.logo" ) {
                    
                }
                
                Text("By signing in to Shema, you are agreeing to our Terms of Service and Privacy Policy.")
                    .font(.fontNunitoRegular(size: 14))
                    .foregroundColor(.theme.secondaryTextColor)
                    .multilineTextAlignment(.center)
                
            }
           
            .padding(.bottom, 16)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.theme.backgroundColor.ignoresSafeArea()
        )
   
   
    }
}

#Preview {
    LoginView()
}
