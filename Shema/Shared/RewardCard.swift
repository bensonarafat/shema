//
//  RewardCard.swift
//  Shema
//
//  Created by Benson Arafat on 13/01/2026.
//

import SwiftUI

struct RewardCard: View {
    let gems: Int
    let keys: Int
    @State private var isGlowing = false
    
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            VStack {
                HStack {
                    Text("Keys")
                    Spacer()
                    HStack (spacing: 8) {
                        Image("key")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                        Text("\(keys)")
                            .foregroundColor(Color.theme.primaryTextColor)
                    }
                }
                .font(.fontNunitoBlack(size: 20))
                .foregroundColor(Color.theme.secondaryTextColor)
                
                Divider()
                    .background(Color.gray)
                
                HStack {
                    Text("Gems")
                    Spacer()
                    
                    HStack (spacing: 8) {
                        Image("gem")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                        Text("\(gems)")
                            .foregroundColor(Color.theme.primaryTextColor)
                    } .font(.fontNunitoBlack(size: 20))
                }
                .font(.fontNunitoBlack(size: 20))
                .foregroundColor(Color.theme.secondaryTextColor)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(
                        LinearGradient(
                            colors: [.blue, .purple, .pink, .blue],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 2
                    )
                    .blur(radius: isGlowing ? 8 : 4)
                    .opacity(isGlowing ? 0.8 : 0.4)
            )
            .padding()
            .onAppear {
                withAnimation(
                    .easeInOut(duration: 1.5)
                    .repeatForever(autoreverses: true)
                ) {
                    isGlowing = true
                }
            }
        }
    }
}

#Preview {
    RewardCard(gems: 20, keys: 5)
}
