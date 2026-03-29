//
//  FocusStepView.swift
//  Shema
//
//  Created by Benson Arafat on 28/03/2026.
//

import SwiftUI

struct FocusStepView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        OnboardingStepContainer(
            title: "What area do you\nwant to focus on?",
            subtitle: "Choose one"
        ) {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(viewModel.focusAreas, id: \.self) { area in
                    OnboardingChip(
                        title: area,
                        isSelected: viewModel.selectedFocus == area
                    ) {
                        viewModel.selectedFocus = area
                    }
                }
            }
        }
    }
}


#Preview {
    FocusStepView()
        .environmentObject(OnboardingViewModel())
}
