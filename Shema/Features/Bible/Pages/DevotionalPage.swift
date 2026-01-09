//
//  DevotionalPage.swift
//  Shema
//
//  Created by Benson Arafat on 09/01/2026.
//

import SwiftUI

struct DevotionalPage: View {
    let title: String
    let content: String
    var body: some View {
        ScrollView {
            VStack (spacing: 24) {
                VStack (spacing: 12) {
                    
                    Text(title)
                        .font(.fontNunitoBlack(size: 32))
                        .foregroundColor(Color.theme.primaryTextColor)
                        .multilineTextAlignment(.leading)
                }
                .padding(.top, 32)
                
                Text(content)
                    .font(
                        title == "Prayer" ? .fontNunitoItalic(size: 20) :
                        .fontNunitoRegular(size: 20))
            
                    .foregroundColor(Color.theme.primaryTextColor)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(6)
                    .padding(.horizontal, 8)
                
                Spacer(minLength: 32)
            }
        }
    }
}
