//
//  FocusTimerCard.swift
//  Shema
//
//  Created by Benson Arafat on 03/11/2025.
//

import SwiftUI

struct FocusTimerCard: View {
    let focus: Focus
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var nav : NavigationManager
    
    var body: some View {
        ZStack (alignment: .leading) {
            RoundedRectangle(cornerRadius: 24)
                .fill(
                    Color.theme.surfaceColor
                )
            VStack (alignment: .leading, spacing: 8) {
                HStack (spacing: 8) {
                    Text(focus.emoji)
                        .font(.system(size: 24))
                    Text(focus.name)
                        .font(.fontNunitoRegular(size: 14))
                }
                HStack (spacing: 4) {
                    Image(systemName: "clock")
                    Text("\(focus.duration)")
                        .font(.fontNunitoRegular(size: 12))
                }
                
                HStack(spacing: 8) {
                    Image(systemName: "play.fill")
                    Text("Start")
                        .font(.fontNunitoRegular(size: 12))
                }
            
            }.padding(20)
        }
        .frame(width: 180, height: 120)
        .cornerRadius(16)
        .onTapGesture {
            nav.push(AppDestination.focus(focus))
        }
    }
}

#Preview {
    let nav = NavigationManager()
    FocusTimerCard(focus: Focus(name: "Name", duration: 60, emoji: "🧠", description: "Sample focus"))
        .environmentObject(nav)
}
