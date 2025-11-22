//
//  BibleScrollAndControl.swift
//  Shema
//
//  Created by Benson Arafat on 21/11/2025.
//

import SwiftUI

struct BibleScrollAndControl: View {
    @EnvironmentObject var bibleViewModel: BibleViewModel
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack (alignment: .bottom) {
            ScrollView {
                VStack (alignment: .center, spacing: 10) {
                   
                    Text("\(bibleViewModel.selectedBook?.name ?? "Genesis") \(bibleViewModel.selectedChapter)")
                        .italic()
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding(.bottom, 8)
                    
                    ForEach(bibleViewModel.verses) { verse in
                        VerseTextView(verse: verse)
                    }
                }
                .padding()
            }
            
            HStack {
                Button {
                    navigateChapter(-1)
                } label : {
                    Image(systemName: "chevron.left")
                    .foregroundColor(.accentColor)
                    .padding(15)
                    .background(
                        Circle()
                            .fill(Color(.systemGray5))
                    )
                }
                .disabled(bibleViewModel.selectedChapter <= 1)
                .opacity(bibleViewModel.selectedChapter <= 1 ? 0.4 : 1)
                
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "play.fill")
                        .foregroundColor(.accentColor)
                        .padding(20)
                        .background(
                            Circle()
                                .fill(Color(.systemGray5))
                        )
                }
                Spacer()
                Button {
                    navigateChapter(1)
                } label : {
                    Image(systemName: "chevron.right")
                    .foregroundColor(.accentColor)
                    .padding(15)
                    .background(
                        Circle()
                            .fill(Color(.systemGray5))
                    )
                }
                .disabled(bibleViewModel.selectedChapter >= (bibleViewModel.selectedBook?.chapters ?? 1))
                .opacity(bibleViewModel.selectedChapter >= (bibleViewModel.selectedBook?.chapters ?? 1) ? 0.4 : 1 )
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
        }
    }
    
    
    private func navigateChapter(_ delta: Int) {
        let maxChapters = bibleViewModel.selectedBook?.chapters ?? 1
        let newChapter = bibleViewModel.selectedChapter + delta
        
        guard newChapter >= 1 && newChapter <= maxChapters else { return }
        
        bibleViewModel.selectedChapter = newChapter
        bibleViewModel.loadChapter()
    }
}

#Preview {
    let vm = BibleViewModel()
    BibleScrollAndControl().environmentObject(vm)
}
