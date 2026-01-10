//
//  Greating.swift
//  Shema
//
//  Created by Benson Arafat on 03/11/2025.
//

import SwiftUI

struct GreatingTheme: View {
    
    @ObservedObject var viewModel: HomeViewModel
    @EnvironmentObject var scriptureService: ScriptureService
    @EnvironmentObject var bookmarkViewModel: BookmarkViewModel
    
    var body: some View {
        HStack (alignment: .top, spacing: 8){
            Image(systemName: viewModel.greetings.icon)
                .font(.system(size: 14, weight: .bold))
            
            Text(scriptureService.scripture?.theme ?? viewModel.greetings.text)
                .textCase(.uppercase)
                .font(.fontNunitoBlack(size: 16))
                .fontWeight(.heavy)
            
            Spacer()
            if scriptureService.scripture?.theme != nil {
                Button {
                    Task {
                        let dailyScripture: DailyScripture? = scriptureService.scripture
                        if dailyScripture != nil {
                        if bookmarkViewModel.isSaved(scriptureService.scripture!.id)  {
                            await bookmarkViewModel.deleteBookmark(scriptureService.scripture!.id)
                        } else{
                                await bookmarkViewModel.addBookmark(dailyScripture!)
                            }
                        }
                        

                    }

                } label : {
                    Image(systemName:
                            bookmarkViewModel.isSaved(scriptureService.scripture!.id) ? "bookmark.fill" : "bookmark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color(hex: "f49000"))
                        .frame(width: 20, height: 20)
                }

            }

        }
        .padding(.horizontal)
        .padding(.vertical, 8)

    }
}

#Preview {
    let scriptureService = ScriptureService()
    let bookmarkViewModel = BookmarkViewModel()
    GreatingTheme(
        viewModel: HomeViewModel()
    )
    .environmentObject(bookmarkViewModel)
    .environmentObject(scriptureService)
}
