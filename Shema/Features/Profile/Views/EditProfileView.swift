//
//  EditProfileView.swift
//  Shema
//
//  Created by Benson Arafat on 06/01/2026.
//

import SwiftUI

struct EditProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @State private var fullName: String = ""
    @State private var username: String = ""
    @FocusState private var isFullNameFocused: Bool
    @FocusState private var isUsernameFocused: Bool
    @State private var isUsernameAvailable: Bool = true
    @State private var isCheckingUsername: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    // Debounce timer for username checking
    @State private var usernameCheckTask: Task<Void, Never>?
    
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
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
                
                VStack (alignment: .leading, spacing: 8) {
                    ZStack (alignment: .leading) {
                        if username.isEmpty {
                            Text("Username")
                                .foregroundColor(.theme.secondaryTextColor)
                        }
                        HStack {
                            TextField("", text: $username)
                                .foregroundColor(Color.theme.secondaryTextColor)
                                .keyboardType(.alphabet)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled(true)
                                .textContentType(.name)
                                .onChange(of: username) { oldValue, newValue in
                                    // Cancel previous check
                                    usernameCheckTask?.cancel()
                                    
                                    // Debounce username checking
                                    usernameCheckTask = Task {
                                        try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
                                        guard !Task.isCancelled else { return }
                                        
                                        if !newValue.isEmpty && newValue != viewModel.currentUser?.username {
                                            await checkUsername(newValue)
                                        } else {
                                            await MainActor.run {
                                                isUsernameAvailable = true
                                                isCheckingUsername = false
                                            }
                                        }
                                    }
                                }
                            
                            if isCheckingUsername {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .scaleEffect(0.8)
                            } else if !username.isEmpty && username != viewModel.currentUser?.username {
                                Image(systemName: isUsernameAvailable ? "checkmark.circle.fill" : "xmark.circle.fill")
                                    .foregroundColor(isUsernameAvailable ? .green : .red)
                            }
                        }
                    }
                    .padding()
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(
                                isUsernameFocused ? Color.theme.secondaryColor :
                                    Color.theme.surfaceColor, lineWidth: 1)
                    )
                    .focused($isUsernameFocused)
                    
                    // Username validation message
                    if !username.isEmpty && !username.isValidUsername {
                        Text("Username must be 3-20 characters (letters, numbers, underscore only)")
                            .font(.fontNunitoRegular(size: 14))
                            .foregroundColor(Color.theme.secondaryTextColor)
                    } else if !username.isEmpty && !isUsernameAvailable && username != viewModel.currentUser?.username {
                        Text("Username is already taken")
                            .font(.fontNunitoRegular(size: 14))
                            .foregroundColor(Color.theme.secondaryTextColor)
                    }

                }

                
                // Error Message
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(.fontNunitoRegular(size: 14))
                        .foregroundColor(Color.theme.secondaryTextColor)
                        .multilineTextAlignment(.center)
                }
                
                // Success Message
                if let successMessage = viewModel.successMessage {
                    Text(successMessage)
                        .font(.fontNunitoRegular(size: 14))
                        .foregroundColor(.green)
                        .multilineTextAlignment(.center)
                }
                
                
                PrimaryButton(title:viewModel.isLoading ? "Updating..." : "Update") {
                    Task {
                        let success = await viewModel.updateProfile(fullName: fullName, username: username)
                        if success {
                            try? await Task.sleep(nanoseconds: 1_000_000_000)
                            dismiss()
                        }
                    }
                }
                .disabled(viewModel.isLoading || !isFormValid)
                .opacity(isFormValid ? 1.0 : 0.6)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            fullName = viewModel.currentUser?.fullName ?? ""
            username = viewModel.currentUser?.username ?? ""
        }
        .onDisappear {
            usernameCheckTask?.cancel()
        }
    }
    

    
    private func checkUsername(_ username: String) async {
        await MainActor.run {
            isCheckingUsername = true
        }
        
        let available = await viewModel.checkUsernameAvailability(username: username)
        
        await MainActor.run {
            isUsernameAvailable = available
            isCheckingUsername = false
        }
    }
    
    private var isFormValid: Bool {
        !fullName.trimmingCharacters(in: .whitespaces).isEmpty &&
        !username.trimmingCharacters(in: .whitespaces).isEmpty &&
        username.isValidUsername &&
        isUsernameAvailable &&
        (fullName != viewModel.currentUser?.fullName || username != viewModel.currentUser?.username)
    }
}

#Preview {
    EditProfileView(viewModel: ProfileViewModel())
}
