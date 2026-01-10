//
//  BookmarkDetailsView.swift
//  Shema
//
//  Created by Benson Arafat on 10/01/2026.
//

import SwiftUI

struct BookmarkDetailsView: View {
    let bookmark: Bookmark
    
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    ForEach (0..<bookmark.verses.count, id: \.self) { index in
                        BookmarkVersePage(verse: bookmark.verses[index])
                            .tag(index,)
                    }
                    
                    DevotionalPage(
                        title: "Reflection", content: bookmark.reflection
                    )
               
                    DevotionalPage(
                        title: "Prayer", content: bookmark.prayer
                    )
                 
                    DevotionalPage(
                        title: "Action Step", content: bookmark.actionStep
                    )
                  
                }
            }
            .padding()

        }
        .navigationTitle(bookmark.theme)
        .navigationBarTitleDisplayMode(.inline)
    }
}

