//
//  TranslationStepView.swift
//  Shema
//
//  Created by Benson Arafat on 28/03/2026.
//

import SwiftUI

struct TranslationStepView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        OnboardingStepContainer(
            title: "Preferred Bible\ntranslation?",
            subtitle: "You can change this later"
        ) {
            VStack(spacing: 12) {
                ForEach(viewModel.translations, id: \.self) { translation in
                    OnboardingChip(
                        title: translation,
                        isSelected: viewModel.selectedTranslation == translation
                    ) {
                        viewModel.selectedTranslation = translation
                    }
                }
            }
        }
    }
}
#Preview {
    TranslationStepView()
        .environmentObject(OnboardingViewModel())
}
