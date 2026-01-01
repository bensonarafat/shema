//
//  ForgotPasswordView.swift
//  Shema
//
//  Created by Benson Arafat on 01/01/2026.
//

import SwiftUI

struct ForgotPasswordView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var nav: NavigationManager
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var email: String = ""
    @FocusState private var isEmailFocused: Bool
    
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 32) {
                VStack  (alignment: .leading, spacing: 8) {
                    Text("Forgot Password!")
                        .font(.fontNunitoExtraBold(size: 20))
                        .fontWeight(.black)
                        .foregroundColor(.theme.primaryTextColor)
                    Text("Reset your password")
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
                                isEmailFocused ? Color.theme.secondaryColor :
                                    Color.theme.surfaceColor, lineWidth: 1)
                    )
                    .focused($isEmailFocused)
                    
                    
                    PrimaryButton(title: "Reset Password") {
                        Task {
                          let response =  await authViewModel.resetPassword(email: email)
                            if response {
                                nav.pop()
                                alertMessage = "Check your email for link to reset your password"
                            } else {
                                alertMessage = authViewModel.errorMessage?.message ?? "Oops, there was an error"
                            }
                            showAlert = true
                        }
                    }
                    .disabled(authViewModel.isLoading)
                    
                }
                
                Spacer()
                
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            if authViewModel.isLoading {
                OverlayLoading()
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: authViewModel.isLoading)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Password Reset"),
                message: Text(alertMessage),
                dismissButton: .default(
                    Text("OK")
                )
            )
        }
    }
}

#Preview {
    let nav = NavigationManager()
    ForgotPasswordView()
        .environmentObject(nav)
}
