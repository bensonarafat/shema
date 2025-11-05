//
//  ThemeVersesView.swift
//  Shema
//
//  Created by Benson Arafat on 04/11/2025.
//

import SwiftUI

struct ThemeVersesView: View {
    @EnvironmentObject var nav: NavigationManager
    @StateObject private var viewModel = FocusViewModel()
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var body: some View {
        ScrollView (showsIndicators: false){
            LazyVStack {
                ForEach (viewModel.focuses) { focus in
                    ZStack {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(
                                colorScheme == .dark ?
                                Color(hex: "1c1c1e") : Color(hex: "ffffff")
                            )
                        HStack {
                            HStack {
                                Text(focus.emoji)
                                Text(focus.name)
                                    .font(.fontNotoSansSemiBold(size: 14))
                            }
                            Spacer()
                            
                            HStack(spacing: 8) {
                                Image(systemName: "play.fill")
                                Text("Start")
                                    .font(.fontNotoSansSemiBold(size: 12))
                            }
                        }.padding(20)
                    }

                    .cornerRadius(16)
                    .onTapGesture {
                        nav.push(AppDestination.focus(focus))
                    }
                    
                }
            }
        }
        .padding(.all, 8)
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Theme Verses")
    }
}

#Preview {
    let nav = NavigationManager()
    ThemeVersesView()
        .environmentObject(nav);
}
