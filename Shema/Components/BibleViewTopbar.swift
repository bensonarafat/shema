//
//  BibleViewTopbar.swift
//  Shema
//
//  Created by Benson Arafat on 21/11/2025.
//

import SwiftUI

struct BibleViewTopbar: View {
    @EnvironmentObject var bibleViewModel: BibleViewModel
    @Environment(\.colorScheme) var colorScheme
    @State private var showingBook = false
    @State private var showingTranslation = false
    var body: some View {
        HStack {
            HStack {
                Button {
                    showingBook.toggle()
                } label: {
                    Text("\(bibleViewModel.selectedBook?.name ?? "Genesis") \(bibleViewModel.selectedChapter)")
                        .font(.headline)
                        .padding(.leading, 16)
                        .padding(.trailing, 5)
                        .padding(.vertical, 6)
                }
                .sheet(isPresented: $showingBook) {
                    BibleBookSheet().presentationDetents([.large])
                        .presentationDragIndicator(.visible)
                }

                    
                Rectangle()
                    .fill(.secondary)
                    .frame(width: 2, height: 30)
                Button {
                    showingTranslation.toggle()
                } label: {
                    Text(bibleViewModel.selectedTranslation)
                        .font(.headline)
                        .padding(.trailing, 16)
                        .padding(.leading, 5)
                        .padding(.vertical, 6)
                }.sheet(isPresented: $showingTranslation) {
                    BibleTranslationSheet().presentationDetents([.large])
                        .presentationDragIndicator(.visible)
                }

            }
            .background(colorScheme == .dark ?
                        Color(hex: "1c1c1e") : Color.white)
            .foregroundColor(.primary)
            .cornerRadius(18)
            
            Spacer()
            HStack (spacing: 20,) {
                Image(systemName: "speaker.wave.2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(colorScheme == .dark ? .white : .black))
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(colorScheme == .dark ? .white : .black))
                Image(systemName: "ellipsis.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(colorScheme == .dark ? .white : .black))
                Image("ai")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                

            }
        }
        .padding(.leading, 8)
        .padding(.trailing, 8)
        
    }
}

#Preview {
    let vm = BibleViewModel()
    BibleViewTopbar().environmentObject(vm)
}
