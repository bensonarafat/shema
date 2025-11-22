//
//  BookList.swift
//  Shema
//
//  Created by Benson Arafat on 22/11/2025.
//

import SwiftUI

struct BookList: View {
    @EnvironmentObject var bibleViewModel: BibleViewModel
    public var book: Book
    @State private var isShowing = false
    @Environment(\.dismiss) var dismiss
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            Button {
                isShowing.toggle()
            } label: {
                HStack {
                    Text(book.name)
                        .foregroundColor(.primary)
                    Spacer()
                    
                    Image(systemName:
                            isShowing  ? "chevron.up" : "chevron.down")
                        .foregroundColor(.secondary)
                }
            }

            .padding(.vertical, 8)
            
            if isShowing {
                LazyVGrid(columns:columns, spacing: 5) {
                    ForEach(Array(1...book.chapters), id: \.self) { i in
                        
                        Button {
//                            bibleViewModel.navigateToReference("\(book.bookid)");
                            dismiss()
                        } label : {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(.secondarySystemBackground))
                                .frame(width: 50, height: 50)
                                .overlay( Text("\(i)") )
                        }
                       
                            
                    }
                }
            }
        }
    }
}
