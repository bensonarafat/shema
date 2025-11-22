//
//  BibleVersesByTheme.swift
//  Shema
//
//  Created by Benson Arafat on 03/11/2025.
//

import SwiftUI


struct BibleVersesByTheme: View {
    @EnvironmentObject var nav: NavigationManager
    @StateObject private var viewModel = FocusViewModel()
    var body: some View {
        VStack {
            HStack {
                Text("Theme Verses")
                    .font(.fontNotoSansSemiBold(size: 14))
                Spacer()
                Button ( action : {
                    nav.push(AppDestination.themeVerses)
                } ) {
                    Image(systemName: "chevron.forward")
                        .foregroundColor(.secondary)
                }
                
            }.padding(.horizontal)
            ScrollView (.horizontal, showsIndicators: false) {
                HStack (spacing: 16) {
                    ForEach (viewModel.loadMinFocuses()) { focus in
                        FocusTimerCard(focus: focus)
                      
                    }
                }.padding(.horizontal)
            }
        }
        .padding(.vertical)
    }
}


#Preview {
    let nav = NavigationManager()
    BibleVersesByTheme()
        .environmentObject(nav)
}
