//
//  SocialButton.swift
//  Shema
//
//  Created by Benson Arafat on 25/03/2026.
//

import SwiftUI

struct SocialButton: View {
    var title: String
    var icon: String? = nil
    var assetIcon: String? = nil
    var bgColor: Color
    var textColor: Color
    
    var onTap: (() -> Void)

    var body: some View {
        Button (action : onTap) {
            HStack (spacing: 12) {
                if let assetIcon {
                      Image(assetIcon)
                          .resizable()
                          .scaledToFit()
                          .frame(width: 25, height: 25)
                  } else if let icon {
                      Image(systemName: icon)
                          .resizable()
                          .scaledToFit()
                          .frame(width: 25, height: 25)
                  }
                Text(title)
                    .font(.appHeadingTitle)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .padding(.horizontal, 16)
            .background(bgColor)
            .foregroundColor(textColor)
            .clipShape(Capsule())
        }

    }
}

