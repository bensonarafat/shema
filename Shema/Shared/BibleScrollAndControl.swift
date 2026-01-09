//
//  BibleScrollAndControl.swift
//  Shema
//
//  Created by Benson Arafat on 21/11/2025.
//

import SwiftUI

struct BibleScrollAndControl: View {
    @EnvironmentObject var bibleViewModel: BibleViewModel
    
    @State private var showSheet: Bool = false
    @State private var selectedVerses: [Verse] = []
    
    var body: some View {
        ZStack (alignment: .bottom) {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            ScrollView {
                VStack (alignment: .center, spacing: 10) {
                   
                    Text("\(bibleViewModel.selectedBook?.name ?? "Genesis") \(bibleViewModel.selectedChapter)")
                        .italic()
                        .font(.fontNunitoBlack(size: 25))
                        .foregroundColor(Color.theme.primaryTextColor)
                        .padding(.bottom, 8)
                    
                    ForEach(bibleViewModel.verses) { verse in
                        VerseTextView(verse: verse, isSelected: Binding(
                            get: { selectedVerses.contains(where: { $0.pk == verse.pk }) },
                            set: { newValue in
                                if newValue {
                                    selectedVerses.append(verse)
//                                    showSheet = true
                                } else {
                                    selectedVerses.removeAll { $0.pk == verse.pk }
                                    if selectedVerses.isEmpty {
                                        showSheet = false
                                    }
                                }
                            }
                        ))
                    }
                }
                .padding()
                .padding(.bottom, 100)
            }
            .sheet(isPresented: $showSheet) {
                SelectedVerseSheet()
                    .presentationDetents([.height(100)])
                    .presentationDragIndicator(.visible)
                    .presentationBackgroundInteraction(.enabled)
                    .interactiveDismissDisabled()
                    
            }
            
//            .overlay(alignment: .bottom) {
//                if showSheet {
//                    SelectedVerseSheet()
//                        .frame(height: 100)
//                        .transition(.move(edge: .bottom))
//                }
//            }
//            .animation(.easeInOut, value: showSheet)
            
            
//            HStack {
//                Button {
//                    navigateChapter(-1)
//                } label : {
//                    Image(systemName: "chevron.left")
//                        .foregroundColor(Color.theme.primaryColor)
//                    .padding(15)
//                    .background(
//                        Circle()
//                            .fill(Color(.systemGray5))
//                    )
//                }
//                .disabled(bibleViewModel.selectedChapter <= 1)
//                .opacity(bibleViewModel.selectedChapter <= 1 ? 0.4 : 1)
//                
//                Spacer()
//                Button {
//                    
//                } label: {
//                    Image(systemName: "play.fill")
//                        .foregroundColor(Color.theme.primaryColor)
//                        .padding(20)
//                        .background(
//                            Circle()
//                                .fill(Color(.systemGray5))
//                        )
//                }
//                Spacer()
//                Button {
//                    navigateChapter(1)
//                } label : {
//                    Image(systemName: "chevron.right")
//                        .foregroundColor(Color.theme.primaryColor)
//                    .padding(15)
//                    .background(
//                        Circle()
//                            .fill(Color(.systemGray5))
//                    )
//                }
//                .disabled(bibleViewModel.selectedChapter >= (bibleViewModel.selectedBook?.chapters ?? 1))
//                .opacity(bibleViewModel.selectedChapter >= (bibleViewModel.selectedBook?.chapters ?? 1) ? 0.4 : 1 )
//            }
//            .padding(.horizontal)
//            .padding(.bottom, 10)
            
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
