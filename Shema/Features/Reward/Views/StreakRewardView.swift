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
    @EnvironmentObject var streakViewModel: StreakViewModel
    @EnvironmentObject var currencyViewModel: CurrencyViewModel
    
    @State private var animateIn = false
    
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            VStack (spacing: 0) {
                DotLottieAnimation(fileName: "lottie_streak", config: AnimationConfig(autoplay: true, loop: true)).view()
                    .frame(width: 250, height: 250)
                
                Text("\(streakViewModel.totalStreak)")
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
            .offset(y: animateIn ? 0 : 300)
            .opacity(animateIn ? 1 : 0)
            .animation(.spring(response: 0.6, dampingFraction: 0.85), value: animateIn)
            .onAppear {
                animateIn = true
                Task {
                    await currencyViewModel.addCurrency(value: 20, currencyType: CurrencyType.xp)
                 try? await streakViewModel.markTodayCompleted()
                }
               
            }

            
        }
        .navigationBarBackButtonHidden(true)
      
    }
}

#Preview {
    let nav = NavigationManager()
    let streakViewModel = StreakViewModel()
    let currencyViewModel = CurrencyViewModel()
    StreakRewardView()
        .environmentObject(nav)
        .environmentObject(currencyViewModel)
        .environmentObject(streakViewModel)
}
