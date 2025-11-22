//
//  BookmarkView.swift
//  Shema
//
//  Created by Benson Arafat on 19/10/2025.
//

import SwiftUI

struct BookmarkView: View {
  
    let verses = ["Card 1", "Card 2", "Card 3", "Card 4"]
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (spacing: 16) {
                    ForEach (verses, id: \.self) { verse in
                        CardView(verse: verse)
                            .padding(.horizontal, 20)
                    }
                }
            }

            .navigationTitle("Saved")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemGroupedBackground))
        }
    }
}

struct CardView: View {
    let verse: String
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack (spacing: 16) {
            HStack  (alignment: .top) {
                HStack {
                    Image(systemName: "book.pages")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                    VStack (alignment: .leading){
                        Text("You saved 1 Corinthians 12: 12 NIV")
                        HStack {
                            Image(systemName: "lock")
                                .font(.caption)
                            Text("Private")
                                .font(.caption)
                        }
                        .padding(.top, 2)
                    }
          
                }
                Spacer()
                Text("5w")
                    .font(.caption)
                    
            }

            Text("12 Just as a body, though one, has many parts, but all its many parts form one body, so it is with Christ.")
                .padding(.bottom, 8)
                .padding(.top, 8)
            HStack {
                HStack {
                    Image(systemName: "heart")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .padding(.trailing, 8)
                    Image(systemName: "message")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                }
                
                Spacer()
                
                Image(systemName: "ellipsis")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
            }
            .padding(.top, 8)
        }
        .frame(alignment: .leading)
        .padding(.all, 20)
        .background(colorScheme == .dark ?
                    Color(hex: "1c1c1e") : Color.white)
        .cornerRadius(16)
        .shadow( color: Color.black.opacity(0.01), radius: 1, x: 0, y: 1)
    }
}

#Preview {
    BookmarkView()
}
