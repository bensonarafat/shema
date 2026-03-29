//
//  OnboardingView.swift
//  Shema
//
//  Created by Benson Arafat on 30/12/2025.
//

import SwiftUI
import AVKit

struct OnboardingView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        
        VStack{
            HStack(alignment: .center) {
                Button {
                    viewModel.previous()
                } label: {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.primaryColorFeatherGreen)
                }
                .opacity(viewModel.currentStep == 0 ? 0 : 1)
                .animation(.easeInOut, value: viewModel.currentStep)
                
                ProgressBar(current: viewModel.currentStep + 1, total: viewModel.totalSteps)
                    .padding(.leading, viewModel.currentStep == 0 ? -28 : 0)
                    .animation(.easeInOut, value: viewModel.currentStep)
            }
            .padding(.top, 16)
            .padding(.horizontal)
            
            
            TabView(selection: $viewModel.currentStep) {
                GoalsStepView().tag(0)
                FocusStepView().tag(1)
                TranslationStepView().tag(2)
                DevotionTimeStepView().tag(3)
                FamilyControlsStepView().tag(4)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut, value: viewModel.currentStep)
            .onAppear {
                UIScrollView.appearance().isScrollEnabled = false
            }
            .onDisappear {
                UIScrollView.appearance().isScrollEnabled = true
            }
        
            Button {
                Task {
                    await viewModel.next(router: router, authManager: authManager)
                }
               
               } label: {
                   if viewModel.loading {
                       ProgressView()
                   } else {
                       Text(viewModel.currentStep == viewModel.totalSteps - 1 ? "Finish" : "Continue")
                           .font(.appButtonPrimary)
                           .foregroundColor(.black)
                           .frame(maxWidth: .infinity)
                           .padding(.vertical, 12)
                           .background(
                               RoundedRectangle(cornerRadius: 25)
                                   .fill(viewModel.canContinue ? Color.primaryColorFeatherGreen : Color.gray.opacity(0.4))
                           )
                   }
                   
               }
               .disabled(!viewModel.canContinue || viewModel.loading)
               .padding(.horizontal)
               .padding(.bottom, 18)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    OnboardingView()
        .environmentObject(OnboardingViewModel())
}

