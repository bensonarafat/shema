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
                .font(.fontNunitoBlack(size: 20))
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
            
            VStack (alignment: .leading, spacing: 4) {
                Text(translation.fullName)
                    .font(.fontNunitoBold(size: 12))
                Text("Updated: \(translation.updated.readableDate)")
                    .font(.fontNunitoRegular(size: 10))
                    
            }
            .padding(.trailing, 16)
            .padding(.leading, 6)
            Spacer()
            
            HStack (spacing : 16 ) {
                if bibleViewModel.isDownloading(translation.shortName) {
                    ProgressView().foregroundColor(.primary)
                } else {
                    if !bibleViewModel.isDownloaded(translation.shortName) {
                        Image(systemName: "cloud")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                    }
                    
                }
                Menu {
                    
                    if !bibleViewModel.isDownloaded(translation.shortName) {
                        Button {
                            bibleViewModel.downloadTranslation(translation.shortName)
                        } label : {
                            Label("Download", systemImage: "arrow.down.circle")
                        }
                    } else {
                        Button {
                            bibleViewModel.deleteTranslation(translation.shortName)
                        } label: {
                            Label ("Remove", systemImage: "trash")
                                .foregroundColor(.red)
                        }
                    }
                } label : {
                    Image(systemName: "ellipsis" )
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16)
                }

            }
            
        
                
        }
        .padding(.all, 8)
        .background(
            translation.shortName == bibleViewModel.selectedTranslation ? Color.primary.opacity(0.1) : Color.clear
        ).cornerRadius(8)
    }
}

