//
//  BibleTranslationSheet.swift
//  Shema
//
//  Created by Benson Arafat on 21/11/2025.
//

import SwiftUI

struct BibleTranslationSheet: View {
    @EnvironmentObject var bibleViewModel: BibleViewModel
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            if bibleViewModel.isLoading {
                LoadingContent()
            } else if let error = bibleViewModel.error {
                ErrorContent(error: error)
            } else {
                VStack {
                    Text("Select Translation")
                        .font(.fontNunitoRegular(size: 15))
                        .padding()
                    
                    ScrollView {
                        LazyVStack (spacing: 16) {
                            ForEach(bibleViewModel.translations) { translation in
                                TranslationList(translation: translation)
                                    .onTapGesture {
                                        bibleViewModel.changeTranslation(translation.shortName)
                                        dismiss()
                                    }
                            }
                        }
                    }
                }
            }
        }
        .padding(.all, 16)
        .onAppear {
            if bibleViewModel.translations.isEmpty{
                bibleViewModel.loadLanguages()
            }
        }
    }
}

#Preview {
    let vm = BibleViewModel()
    BibleTranslationSheet()
        .environmentObject(vm)
}
