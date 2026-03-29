//
//  DevotionTimeStepView.swift
//  Shema
//
//  Created by Benson Arafat on 28/03/2026.
//

import SwiftUI


struct DevotionTimeStepView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        OnboardingStepContainer(
            title: "When do you want\nyour daily devotion?",
            subtitle: "We'll remind you at this time every day"
        ) {
            DatePicker(
                "",
                selection: $viewModel.devotionTime,
                displayedComponents: .hourAndMinute
            )
            .datePickerStyle(.wheel)
            .labelsHidden()
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    DevotionTimeStepView()
        .environmentObject(OnboardingViewModel())
}
