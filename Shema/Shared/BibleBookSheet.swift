//
//  BibleBookSheet.swift
//  Shema
//
//  Created by Benson Arafat on 21/11/2025.
//

import SwiftUI

struct BibleBookSheet: View {
    @EnvironmentObject var bibleViewModel: BibleViewModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {
            if bibleViewModel.isLoading {
                LoadingContent()
            } else if let error = bibleViewModel.error {
                ErrorContent(error: error)
            } else {
                VStack {
                    Text("Select Book")
                        .font(.fontNunitoRegular(size: 15))
                        .padding()
                    ScrollView (showsIndicators: false) {
                        LazyVStack {
                            ForEach (bibleViewModel.books) { book in
                                BookList(book: book)
                            }
                        }
                    }
                }
            }
        }.padding(.all, 16)
            .onAppear {
                if bibleViewModel.books.isEmpty{
                    bibleViewModel.loadBooks()
                }
            }
        
    }
}

#Preview {
    let vm = BibleViewModel()
    BibleBookSheet().environmentObject(vm)
}
