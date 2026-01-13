//
//  BibleViewTopbar.swift
//  Shema
//
//  Created by Benson Arafat on 21/11/2025.
//

import SwiftUI

struct BibleViewTopbar: View {
    @EnvironmentObject var bibleViewModel: BibleViewModel
    @EnvironmentObject var nav: NavigationManager
    @State private var showingBook = false
    @State private var showingTranslation = false
    var body: some View {
        HStack {
            HStack {
                Button {
                    showingBook.toggle()
                } label: {
                    Text("\(bibleViewModel.selectedBook?.name ?? "Genesis") \(bibleViewModel.selectedChapter)")
                        .font(.fontNunitoBold(size: 16))
                        .padding(.leading, 16)
                        .padding(.trailing, 5)
                        .padding(.vertical, 6)
                }
                .sheet(isPresented: $showingBook) {
                    BibleBookSheet().presentationDetents([.large])
                        .presentationDragIndicator(.visible)
                }
                .padding(4)

                    
                Rectangle()
                    .fill(Color.theme.surfaceColor.opacity(0.3))
                    .frame(width: 2, height: 30)
                Button {
                    showingTranslation.toggle()
                } label: {
                    Text(bibleViewModel.selectedTranslation)
                        .font(.fontNunitoBold(size: 16))
                        .padding(.trailing, 16)
                        .padding(.leading, 5)
                        .padding(.vertical, 6)
                }.sheet(isPresented: $showingTranslation) {
                    BibleTranslationSheet().presentationDetents([.large])
                        .presentationDragIndicator(.visible)
                }
                .padding(4)

            }
            .background(Color(hex: "1c2923"))
            .foregroundColor(Color.theme.secondaryTextColor)
            .cornerRadius(18)
            
            Spacer()
            HStack (spacing: 20,) {
//                Image(systemName: "magnifyingglass")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 25, height: 25)
//                    .foregroundColor(.white)
                
                Button {
                    if !bibleViewModel.verses.isEmpty {
                    
                        let bibleArg = BibleArg(verses: bibleViewModel.verses, chapter: bibleViewModel.selectedChapter, book: bibleViewModel.selectedBook )
                        nav.push(AppDestination.shemaai(bibleArg))
                    }
                    
                } label: {
                    Image("ai")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35)
                }
                
            }
        }
        .padding(.leading, 8)
        .padding(.trailing, 12)
        .padding(.vertical, 4)
        .background(Color.theme.backgroundColor)
        
    }
}

#Preview {
    let vm = BibleViewModel()
    let nav = NavigationManager()
    BibleViewTopbar()
        .environmentObject(vm)
        .environmentObject(nav)
}

