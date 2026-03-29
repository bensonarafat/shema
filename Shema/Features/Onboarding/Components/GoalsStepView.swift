//
//  GoalsStepView.swift
//  Shema
//
//  Created by Benson Arafat on 28/03/2026.
//

import SwiftUI



struct GoalsStepView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        OnboardingStepContainer(
            title: "What are you hoping\nto get from this?",
            subtitle: "Choose one"
        ) {
            VStack(spacing: 12) {
                ForEach(viewModel.goals, id: \.self) { goal in
                    OnboardingChip(
                        title: goal,
                        isSelected: viewModel.selectedGoal == goal
                    ) {
                        viewModel.selectedGoal = goal
                    }
                }
            }
        }
    }
}

#Preview {
    GoalsStepView()
        .environmentObject(OnboardingViewModel())
}


