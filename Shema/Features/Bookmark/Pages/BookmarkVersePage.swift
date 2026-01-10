//
//  BookmarkVersePage.swift
//  Shema
//
//  Created by Benson Arafat on 10/01/2026.
//

import SwiftUI

struct BookmarkVersePage: View {
    let verse: BookmarkVerse
    @EnvironmentObject var scriptureService: ScriptureService
    var body: some View {
        VStack (spacing: 24) {
            // Opening Quote
            HStack {
                Text("\"")
                    .font(.fontNunitoBlack(size: 60))
                    .fontWeight(.black)
                    .foregroundColor(Color.theme.primaryColor.opacity(0.7))
                
                Spacer()
            }
            .padding(.leading, -8)
            
            // Scripture Text
            Text(verse.text)
                .font(.fontNunitoBlack(size: 28))
                .foregroundColor(Color.theme.primaryTextColor)
                .multilineTextAlignment(.center)
                .lineSpacing(8)
            
            // Reference
            HStack (spacing: 8) {
                Text(verse.reference)
                    .font(.fontNunitoRegular(size: 16))
                Text("•")
                    .font(.fontNunitoRegular(size: 16))
                Text(scriptureService.getTranslationName())
                    .font(.fontNunitoRegular(size: 16))
            }
            .foregroundColor(Color.theme.primaryTextColor.opacity(0.6))
            
            // Closing Quote
            HStack {
                Spacer()
                Text("\"")
                    .font(.fontNunitoBlack(size: 60))
                    .foregroundColor(Color.theme.primaryColor.opacity(0.7))
            }
            .padding(.trailing, -8)
        }
        .padding(.horizontal, 32)
    }
}
