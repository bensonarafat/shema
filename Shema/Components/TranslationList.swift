//
//  TranslationList.swift
//  Shema
//
//  Created by Benson Arafat on 22/11/2025.
//

import SwiftUI

struct TranslationList: View {
    @EnvironmentObject var bibleViewModel: BibleViewModel
    public let translation: Translation
    var body: some View {
        HStack {
            Text(translation.shortName)
                .multilineTextAlignment(.center)
                .frame(width: 60, height: 60)
                .padding(2)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.secondary.opacity(0.15))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.primary, lineWidth: 0.5)
                )
            
            VStack (alignment: .leading) {
                Text(translation.fullName)
                    .font(.fontNotoSansBlack(size: 14))
                Text("Updated: 10th Aug, 2025")
                    .font(.fontNotoSansLight(size: 12))
                    
            }
            Spacer()
            
            Button {
                if !bibleViewModel.isDownloaded(translation.shortName) {
                    bibleViewModel.downloadTranslation(translation.shortName)
                }
            } label: {
                if bibleViewModel.downloading {
                    ProgressView().foregroundColor(.primary)
                } else {
                    Image(systemName:
                            bibleViewModel.isDownloaded(translation.shortName) ?
                          "arrow.down.circle.fill" : "arrow.down.circle.dotted"  )
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                }
                
                
            }
        
                
        }
        .padding(.all, 8)
        .background(
            translation.shortName == bibleViewModel.selectedTranslation ? Color.primary.opacity(0.1) : Color.clear
        ).cornerRadius(8)
    }
}

