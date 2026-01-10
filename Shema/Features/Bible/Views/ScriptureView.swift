//
//  ScriptureView.swift
//  Shema
//
//  Created by Benson Arafat on 04/01/2026.
//

import SwiftUI
import Combine

struct ScriptureView: View {
    @EnvironmentObject var bookmarkViewModel: BookmarkViewModel
    @EnvironmentObject var streakViewModel: StreakViewModel
    let scripture: DailyScripture
    let totalPages: Int
    @State private var totalKeys: Int = 1
    @State private var timerRemaining: Int = 3
    
    let timer = Timer.publish(every: 1, on: .main, in: .common)
                      .autoconnect()
    
    init(scripture: DailyScripture) {
        self.scripture = scripture
        self.totalPages = scripture.verses.count + 3
    }
    
    @EnvironmentObject private var nav: NavigationManager
    @State private var currentPage = 0
    var progress: CGFloat {
        CGFloat(currentPage + 1) / CGFloat(totalPages)
    }
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            VStack (spacing: 0){
                HStack (spacing: 16) {
                    
                    Button {
                        if currentPage > 0 {
                            withAnimation {
                                currentPage -= 1
                            }
                        } else {
                            nav.pop()
                        }
                        
                    } label:  {
                        Image(systemName: currentPage > 0 ? "chevron.left" : "xmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 18)
                            .foregroundColor(.theme.surfaceColor)
                        
                    }
                    
                    GeometryReader { geometry in
                        ZStack (alignment: .leading) {
                            
                            Rectangle()
                                .fill(Color.theme.surfaceColor)
                                .frame(height: 16)
                                .cornerRadius(40)
                            
                            Rectangle()
                                .fill(
                                    LinearGradient (colors: [
                                        .theme.primaryColor,
                                        .theme.secondaryColor,
                                    ],
                                                    startPoint: .leading,
                                                    endPoint: .trailing
                                    )
                                )
                                .frame(width: geometry.size.width * progress, height: 16)
                                .cornerRadius(40)
                                .animation(.easeInOut(duration: 0.3), value: currentPage)
                        }
                        
                    }
                    
                    HStack (spacing: 8) {
                        Text("🔑")
                        Text("\(totalKeys)")
                            .foregroundColor(Color.theme.primaryTextColor)
                    } .font(.fontNunitoBlack(size: 20))
                }
                .frame(height: 16)
                
                TabView(selection: $currentPage) {
                    ForEach (0..<scripture.verses.count, id: \.self) { index in
                        VersePage(verse: scripture.verses[index])
                            .tag(index,)
                    }
                    
                    DevotionalPage(
                        title: "Reflection", content: scripture.reflection
                    )
                    .tag(scripture.verses.count)
                    
                    
                    DevotionalPage(
                        title: "Prayer", content: scripture.prayer
                    )
                    .tag(scripture.verses.count + 1)
                    
                    DevotionalPage(
                        title: "Action Step", content: scripture.actionStep
                    )
                    .tag(scripture.verses.count + 2)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.easeInOut, value: currentPage)
                
                HStack {
                
                    PrimaryButton(
                        title: timerRemaining == 0 ? isLastPage ? "Complete" : "Continue" : "\(timerRemaining)s",
                        backgroundColor: timerRemaining == 0 ? Color.theme.secondaryColor : Color(hex: "37474e"),
                        foregroundColor: timerRemaining == 0 ? Color.black :  Color(hex: "51636b"),
                    ) {
                        if timerRemaining == 0 {
                            handleContinue()
                        }
                    }
                    .disabled(
                        timerRemaining == 0 ? false : true )
                    .onReceive(timer) { _ in
                        if timerRemaining > 0 {
                            timerRemaining -= 1
                        }
                        
                    }
                    
                    if isLastPage {
                        Button {
                            Task {
                            
                                if bookmarkViewModel.isSaved(scripture.id)  {
                                    await bookmarkViewModel.deleteBookmark(scripture.id)
                                } else{
                                   await bookmarkViewModel.addBookmark(scripture)
                                }
                            }
                        } label: {
                            Image(systemName:
                                    bookmarkViewModel.isSaved(scripture.id) ? "bookmark.fill" : "bookmark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color(hex: "f49000"))
                                .frame(width: 35, height: 35)
                        }
                    }
                }
                
               
            }
            .padding()
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func handleContinue() {
           if isLastPage {
               nav.popToRoot()
               if !streakViewModel.isStreakToday() {
                   nav.push(AppDestination.streakReward)
               }

           } else {
               withAnimation {
                   totalKeys += 1
                   currentPage += 1
                   timerRemaining = 5
               }
           }
       }
    
    private var isLastPage: Bool {
           currentPage == totalPages - 1
       }
}

