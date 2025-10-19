//
//  OnboardingView.swift
//  Shema
//
//  Created by Benson Arafat on 10/10/2025.
//

import SwiftUI
import FamilyControls

struct OnboardingView: View {
    @EnvironmentObject var viewModel: BibleLockViewModel
    @State var selection = FamilyActivitySelection()
    @ObservedObject var appBlockingService = AppBlockingService()
    @State private var currentStep = 0
    @State private var showingError = false
    @State private var errorMessage = ""
    @State private var isAuthorized = false
    
    var body: some View {
        VStack (spacing: 30) {
            Spacer()
            
            // Step indicator
            HStack (spacing: 8) {
                ForEach(0..<3) { index in
                    Circle()
                        .fill(index <= currentStep ? Color.blue : Color.gray.opacity(0.3))
                        .frame(width: 10, height: 10)
                    
                }
            }
            .padding(.bottom, 20)
            
            // Content based on step
            Group {
                switch currentStep {
                case 0:
                    stepOne
                case 1:
                    stepTwo
                case 2:
                    stepThree
                default:
                    EmptyView()
                }
            }
            
            Spacer()
            
            // Navigation buttons
            HStack (spacing: 20) {
                if currentStep > 0 {
                    Button("Back") {
                        withAnimation {
                            currentStep -= 1
                        }
                    }
                    .buttonStyle(.bordered)
                }
                
                Button(currentStep == 2 ? "Get Started" : "Next") {
                    handleNext()
                }
                .buttonStyle(.bordered)
                .disabled(currentStep == 1 && !isAuthorized)
            }
            .padding()
        }
        .padding()
        .alert("Error", isPresented: $showingError) {
            Button("OK") {
                
            }
        } message: {
            Text(errorMessage)
        }
        .onAppear {
            isAuthorized = viewModel.appBlockingService.isAuthorized
            loadSavedSelection()
        }
    }
    
    var stepOne: some View {
        VStack (spacing: 20) {
            Image(systemName: "book.fill")
                .font(.system(size: 80))
                .foregroundStyle(.blue)
            
            Text("Welcome to Shema")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Read the Bible daily and stay focused by limitting app distractions")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)
        }
    }
    
    var stepTwo: some View {
        VStack (spacing: 20) {
            Image(systemName: "lock.shield.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
            
            Text("Grant Permissions")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Shema needs Family Controls permission to manage app access")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            if isAuthorized {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    Text("Permission Granted")
                        .foregroundColor(.green)
                }
                .padding()
                .background(Color.green.opacity(0.1))
                .cornerRadius(10)
            } else {
                Button {
                    Task {
                        do {
                            try await viewModel.appBlockingService.requestAuthorization()
                            isAuthorized = viewModel.appBlockingService.isAuthorized
                        } catch {
                            errorMessage = "Failed to get permission: \(error.localizedDescription)"
                            showingError = true
                        }
                    }
                } label: {
                    Text("Grant Permission")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
        }
    }
    
    var stepThree: some View {
        VStack(spacing: 20) {
            Image(systemName: "apps.iphone")
                .font(.system(size: 80))
                .foregroundColor(.blue)
            
            Text("Select Apps to Lock")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Choose which apps require Bible reading to unlock")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            Button {
                
                guard isAuthorized else {
                    print("Permission is required to access app list")
                    return
                }
                viewModel.showingAppPicker = true
            } label: {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Select Apps")
                }
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding(.horizontal)
            .familyActivityPicker(
                isPresented: $viewModel.showingAppPicker,
                selection: $selection
            )
            .onChange(of: selection) { oldValue, newValue in
                viewModel.appBlockingService.saveBlockedApps(newValue)
            }
           
            
            if !viewModel.appBlockingService.blockedApps.isEmpty || !viewModel.appBlockingService.blockedCategories.isEmpty {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    Text("\(viewModel.appBlockingService.blockedApps.count) apps selected and \(viewModel.appBlockingService.blockedCategories.count) categories selected")
                        .foregroundColor(.green)
                }
                .padding()
                .background(Color.green.opacity(0.1))
                .cornerRadius(10)
            }
        }
    }

    func handleNext() {
        if currentStep < 2 {
            withAnimation {
                currentStep += 1
            }
        } else {
            viewModel.completeOnboarding()
            viewModel.updateAppBlockingStatus()
        }
    }
    
    func loadSavedSelection() {
        if let loadedSelection = viewModel.appBlockingService.loadBlockedApps() {
            selection = loadedSelection
        }
    }
}

#Preview {
    OnboardingView()
}

