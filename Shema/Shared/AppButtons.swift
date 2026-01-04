//
//  AppButtons.swift
//  Shema
//
//  Created by Benson Arafat on 30/12/2025.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    var icon: String? = nil
    var customImage: String? = nil
    var backgroundColor: Color = Color.theme.secondaryColor
    var foregroundColor: Color = .black
    var cornerRadius: CGFloat = 16
    var action: () -> Void
    var body: some View {
        Button {
            action()
        } label : {
            
            HStack (spacing: 8) {
                if let customImage = customImage {
                    Image(customImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                }
                else  if let icon = icon {
                    Image(systemName: icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.black)
                }
                Text(title)
                    .textCase(.uppercase)
                    .font(.fontNunitoExtraBold(size: 14))
                    .fontWeight(.heavy)
                    .foregroundColor(foregroundColor)

                
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
        }
    }
}


struct SecondaryButton: View {
    let title: String
    var icon: String? = nil
    var customImage: String? = nil
    var backgroundColor: Color = Color.clear
    var foregroundColor: Color = .theme.secondaryColor
    var cornerRadius: CGFloat = 16
    var borderColor: Color = .theme.surfaceColor
    var borderWidth: CGFloat = 1
    var action: () -> Void
    
    var body: some View {
        Button {
           action()
        } label: {
            HStack (spacing: 8) {
                if let customImage = customImage {
                    Image(customImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                }
                else  if let icon = icon {
                    Image(systemName: icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.theme.primaryTextColor)
                }
                Text(title)
                    .textCase(.uppercase)
                    .font(.fontNunitoExtraBold(size: 14))
                    .fontWeight(.heavy)
                    .foregroundColor(foregroundColor)
                
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .overlay (
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
        }
    }
}
