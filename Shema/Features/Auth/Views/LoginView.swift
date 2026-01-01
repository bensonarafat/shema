//
//  LoginView.swift
//  Shema
//
//  Created by Benson Arafat on 30/12/2025.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var nav: NavigationManager
    @State private var email = ""
    @FocusState private var emailIsFocused: Bool
    
    @State private var password = ""
    @FocusState private var passwordIsFocused: Bool
    
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
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
                                .keyboardType(.emailAddress)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled(true)
                                .textContentType(.emailAddress)
                                
                        }
                        .padding()
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
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled(true)
                                .textContentType(.password)
                        }
                            .padding()
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(
                                        passwordIsFocused ? Color.theme.secondaryColor :
                                        Color.theme.surfaceColor, lineWidth: 1)
                            )
                            .focused($passwordIsFocused)
                        
                        HStack {
                            Spacer()
                            
                            Text("Forgot Password?")
                                .font(.fontNunitoBold(size: 14))
                                .foregroundColor(Color.theme.primaryTextColor)
                                .multilineTextAlignment(.trailing)
                                .padding(.trailing, 8)
                                .onTapGesture {
                                    nav.push(AppDestination.forgotPassword)
                                }
                        }
                       
                        
                        PrimaryButton(title: "Login") {
                            Task {
                                await authViewModel.signIn(email: email, password: password)
                            }
                        }
                        .disabled(authViewModel.isLoading)
                        
                        
                        Text("Don't have an account? Register")
                            .font(.fontNunitoBold(size: 14))
                            .foregroundColor(Color.theme.primaryTextColor)
                            .multilineTextAlignment(.trailing)
                            .padding(.trailing, 8)
                            .onTapGesture {
                                nav.push(AppDestination.register)
                            }

                    }
                   
                }
                
                Spacer()
                VStack (spacing: 16) {
                    
                    SecondaryButton(title: "sign up with google", customImage: "google" ) {
                        Task {
                            await authViewModel.signInWithGoogle()
                        }
                    }.disabled(authViewModel.isLoading)
                    SecondaryButton(title: "sign up with apple", icon: "apple.logo" ) {
                        Task {
                            await authViewModel.signInWithApple()
                        }
                    }.disabled(authViewModel.isLoading)
                    
                    Text("By signing in to Shema, you are agreeing to our Terms of Service and Privacy Policy.")
                        .font(.fontNunitoRegular(size: 14))
                        .foregroundColor(.theme.secondaryTextColor)
                        .multilineTextAlignment(.center)
                    
                }
                .padding(.bottom, 16)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            if authViewModel.isLoading {
                OverlayLoading()
                    .transition(.opacity)
            }

        }
        .animation(.easeInOut(duration: 0.2), value: authViewModel.isLoading)
        .alert(item: $authViewModel.errorMessage) { error in
            Alert(
                title: Text("Login Error"),
                message: Text(error.message),
                dismissButton: .default(
                    Text("OK")
                ) {
                    authViewModel.clearError()
                }
            )
        }
        .onChange(of: authViewModel.isAuthenticated) { oldValue, newValue in
            if newValue {
                nav.popToRoot()
                nav.push(AppDestination.tabs)
            }
        }
    }
}

#Preview {
    let vm = AuthViewModel()
    let nav = NavigationManager()
    LoginView()
        .environmentObject(vm)
        .environmentObject(nav)
}
