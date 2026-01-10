//
//  BookmarkView.swift
//  Shema
//
//  Created by Benson Arafat on 19/10/2025.
//

import SwiftUI

struct BookmarkView: View {
    @EnvironmentObject var bookmarkViewModel: BookmarkViewModel
    @EnvironmentObject var nav: NavigationManager
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            if bookmarkViewModel.bookmarks.isEmpty {
                
                VStack (alignment: .center) {
                
                    Image("empty-box")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                    
                    Text("Add Bookmarks")
                        .font(.fontNunitoBlack(size: 30))
                        .foregroundColor(Color.theme.primaryTextColor)
                    
                    Text("Don't forget to bookmark the daily verse you like the most so that you can find those later on! ")
                        .font(.fontNunitoRegular(size: 20))
                        .foregroundColor(Color.theme.secondaryTextColor)
                        .multilineTextAlignment(.center)
                    
                } .padding()

            } else {
                ScrollView {
                    
                    VStack (spacing: 16) {
                        ForEach (bookmarkViewModel.bookmarks, id: \.self) { bookmark in
                            Button {
                                nav.push(AppDestination.bookmarkDetail(bookmark))
                            } label: {
                                CardView(bookmark: bookmark)
                                    .padding(.horizontal, 20)
                            }
                            
                        }
                    }

                }
            }

        }
        .navigationTitle("Saved")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CardView: View {
    let bookmark: Bookmark

    var body: some View {
        VStack (spacing: 8) {
            HStack  (alignment: .top) {
                HStack () {
                    Image(systemName: "book.pages")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                    Text("You saved \(bookmark.reference) \(bookmark.verses.first?.book ?? "KJV")")
                        .foregroundColor(Color.theme.primaryTextColor)
                        .font(.fontNunitoBold(size: 16))
                        .multilineTextAlignment(.leading)
          
                }
                Spacer()
                Text("\(bookmark.date.toReadableDate(outputFormat: "EEE, MMM d") ?? "few seconds ago")")
                    .font(.fontNunitoRegular(size: 12))
                    .foregroundColor(Color.theme.primaryTextColor)
            }

            Text("\(bookmark.verses.first?.text ?? "")")
                .font(.fontNunitoRegular(size: 16))
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
    let vm = BookmarkViewModel()
    let nav = NavigationManager()
    BookmarkView()
        .environmentObject(vm)
        .environmentObject(nav)
}
