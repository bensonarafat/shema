//
//  OnboardingStepContainer.swift
//  Shema
//
//  Created by Benson Arafat on 28/03/2026.
//

import SwiftUI

struct OnboardingStepContainer<Content: View>: View {
    let title: String
    let subtitle: String
    let content: () -> Content
    
    var body: some View {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.appDisplay)
                        .fontWeight(.bold)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text(subtitle)
                        .font(.appFootnote)
                        .foregroundColor(.secondary)
                }
                
                content()
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 8)
    }
}
