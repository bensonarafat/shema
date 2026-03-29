//
//  OnboardingChip.swift
//  Shema
//
//  Created by Benson Arafat on 28/03/2026.
//

import SwiftUI

struct OnboardingChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        VStack {
            Button(action: action) {
                HStack {
                    Text(title)
                        .font(.appButtonSmall)
                        .foregroundColor(.primary)
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 25)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(isSelected ? Color.primaryColorFeatherGreen.opacity(0.1) : Color.gray.opacity(0.1))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isSelected ? Color.primaryColorFeatherGreen : Color.gray.opacity(0.2), lineWidth: 1)
                )
               
            }
        }

    }
}


#Preview {
    OnboardingChip(title: "Grow closer to God", isSelected: true) {}
}
