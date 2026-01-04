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
    }
}

struct CardView: View {
    let verse: String

    var body: some View {
        VStack (spacing: 16) {
            HStack  (alignment: .top) {
                HStack {
                    Image(systemName: "book.pages")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                    VStack (alignment: .leading){
                        Text("You saved 1 Corinthians 12: 12 NIV")
                            .foregroundColor(Color.theme.primaryTextColor)
                            .font(.fontNunitoBold(size: 16))
                    }
          
                }
                Spacer()
                Text("5w")
                    .font(.fontNunitoRegular(size: 12))
                    .foregroundColor(Color.theme.primaryTextColor)
                    
            }

            Text("12 Just as a body, though one, has many parts, but all its many parts form one body, so it is with Christ.")
                .font(.fontNunitoRegular(size: 14))
                .foregroundColor(Color.theme.primaryTextColor)
                .padding(.bottom, 8)
                .padding(.top, 8)
        }
        .frame(alignment: .leading)
        .padding(.all, 20)
        .background(Color(hex: "1c2923"))
        .cornerRadius(16)
        .shadow( color: Color.black.opacity(0.01), radius: 1, x: 0, y: 1)
    }
}

#Preview {
    BookmarkView()
}
