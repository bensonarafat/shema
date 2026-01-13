//
//  RegisterView.swift
//  Shema
//
//  Created by Benson Arafat on 30/12/2025.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var nav: NavigationManager

    @State private var email: String = ""
    @FocusState private var isEmailFocused: Bool
    @State private var fullName: String = ""
    @FocusState private var isFullNameFocused: Bool
    @State private var password: String = ""
    @FocusState private var isPasswordFocused: Bool
    @State private var confirmPassword: String  = ""
    @FocusState private var isConfirmPasswordFocused: Bool
    
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            VStack {
                
                // Register Form
                VStack (alignment: .leading, spacing: 32) {
                    
                    VStack  (alignment: .leading, spacing: 8) {
                        Text("Welcome!")
                            .font(.fontNunitoExtraBold(size: 20))
                            .fontWeight(.black)
                            .foregroundColor(.theme.primaryTextColor)
                        Text("Create your account")
                            .font(.fontNunitoRegular(size: 16))
                            .fontWeight(.heavy)
                            .foregroundColor(.theme.primaryTextColor)
                    }
                    
                    VStack (spacing: 16) {
                        
                        ZStack (alignment: .leading) {
                            if fullName.isEmpty {
                                Text("Full Name")
                                    .foregroundColor(.theme.secondaryTextColor)
                            }
                            TextField("", text: $fullName)
                                .foregroundColor(Color.theme.secondaryTextColor)
                                .keyboardType(.alphabet)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled(true)
                                .textContentType(.name)
                        }
                        .padding()
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(
                                    isFullNameFocused ? Color.theme.secondaryColor :
                                        Color.theme.surfaceColor, lineWidth: 1)
                        )
                        .focused($isFullNameFocused)
                        
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
                                    isEmailFocused ? Color.theme.secondaryColor :
                                        Color.theme.surfaceColor, lineWidth: 1)
                        )
                        .focused($isEmailFocused)
                        
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
                                    isPasswordFocused ? Color.theme.secondaryColor :
                                        Color.theme.surfaceColor, lineWidth: 1)
                        )
                        .focused($isPasswordFocused)
                        
                        
                        ZStack (alignment: .leading) {
                            if confirmPassword.isEmpty {
                                Text("Confirm Password")
                                    .foregroundColor(.theme.secondaryTextColor)
                            }
                            SecureField("", text: $confirmPassword)
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
                                    isConfirmPasswordFocused ? Color.theme.secondaryColor :
                                        Color.theme.surfaceColor, lineWidth: 1)
                        )
                        .focused($isConfirmPasswordFocused)
                        
                        PrimaryButton(title: "Register",
                                      backgroundColor: isValid() ? Color.theme.macaw : Color(hex: "37474e"),
                                      foregroundColor: isValid() ? Color.black : Color(hex: "51636b"),
                        ) {
                            Task {
                                await authViewModel.signUp(email: email,
                                                           password: password,
                                                           fullName: fullName,
                                                           confirmPassword: confirmPassword)
                            }
                        }
                        .disabled(authViewModel.isLoading)
                        
                    }
                    
                }
                
                Spacer()
                VStack (spacing: 16) {
                    
                    SecondaryButton(title: "sign up with google", customImage: "google", foregroundColor: Color.white ) {
                        Task {
                            await authViewModel.signInWithGoogle()
                        }
                    }
                    .disabled(authViewModel.isLoading)
                    
                    SecondaryButton(title: "sign up with apple", icon: "apple.logo", foregroundColor: Color.white ) {
                        Task {
                            await authViewModel.signInWithApple()
                        }
                    }
                    .disabled(authViewModel.isLoading)
                    
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
                title: Text("Register Error"),
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
    
    func isValid() -> Bool {
        return !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty && !fullName.isEmpty
    }
}

#Preview {
    let vm = AuthViewModel()
    let nav = NavigationManager()
    RegisterView()
        .environmentObject(vm)
        .environmentObject(nav)
}
