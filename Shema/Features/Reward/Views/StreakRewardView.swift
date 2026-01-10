//
//  StreakRewardView.swift
//  Shema
//
//  Created by Benson Arafat on 09/01/2026.
//

import SwiftUI
import DotLottie

struct StreakRewardView: View {
    @EnvironmentObject var nav: NavigationManager
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            VStack (spacing: 0) {
                DotLottieAnimation(fileName: "lottie_streak", config: AnimationConfig(autoplay: true, loop: true)).view()
                    .frame(width: 250, height: 250)
                
                Text("1")
                    .font(.fontNunitoBlack(size: 100))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color(hex: "f49000"), Color(hex: "ffc200")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing,
                        )
                    )
                Text("day streak")
                    .font(.fontNunitoBlack(size: 30))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color(hex: "f49000"), Color(hex: "ffc200")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing,
                        )
                    )
                StreakCalendar()
                    .padding(.vertical, 16)
                
                Spacer()
                PrimaryButton(title: "Claim 20 XP",
                              backgroundColor: Color.theme.macaw,
                ) {
                    nav.popToRoot()
                    nav.push(AppDestination.currencyReward)
                }
            }
            .padding()

            
        }
        .navigationBarBackButtonHidden(true)
      
    }
}

#Preview {
    let nav = NavigationManager()
    StreakRewardView()
        .environmentObject(nav)
}
