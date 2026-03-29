//
//  FamilyControlsStepView.swift
//  Shema
//
//  Created by Benson Arafat on 28/03/2026.
//

import SwiftUI
import FamilyControls

struct FamilyControlsStepView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        OnboardingStepContainer(
            title: "Block distractions\nuntil you're done",
            subtitle: "Choose apps to block until your devotion is complete"
        ) {
            VStack(spacing: 16) {
                if !viewModel.isAuthorized {
                    // Request permission first
                    VStack(spacing: 15) {
                        Image(systemName: "lock.shield.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.primaryColorFeatherGreen)
                        
                        Text("This uses Apple's Screen Time to block selected apps until you finish your devotion.")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                        
                        Button {
                            Task {
                                await viewModel.requestFamilyControls()
                            }
                        } label: {
                            if viewModel.requestLoading {
                                ProgressView()
                            }else {
                                Text("Allow Screen Time Access")
                                    .foregroundColor(.white)
                                    .padding(.vertical, 14)
                                    .frame(maxWidth: .infinity)
                                    .background(
                                        RoundedRectangle(cornerRadius: 50)
                                            .fill(Color.primaryColorFeatherGreen)
                                    )
                            }
                    
                        }
    

                    }
                } else {
                    // Show app picker
                    VStack(spacing: 12) {
                        Image(systemName: "checkmark.shield.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.primaryColorFeatherGreen)
                        
                        Text("Screen Time access granted!")
                            .fontWeight(.semibold)
                        
                        FamilyActivityPicker(selection: $viewModel.activitySelection)
                            .frame(maxHeight: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    .frame(maxHeight: .infinity)
                }
            }
            .padding(.horizontal, 4)
        }
    }
}


#Preview {
    FamilyControlsStepView()
        .environmentObject(OnboardingViewModel())
}
