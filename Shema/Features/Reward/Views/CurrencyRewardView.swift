//
//  RewardView.swift
//  Shema
//
//  Created by Benson Arafat on 09/01/2026.
//

import SwiftUI
import DotLottie

struct CurrencyRewardView: View {
    @EnvironmentObject var nav: NavigationManager
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            VStack {
                DotLottieAnimation(fileName: "lottie_reward", config: AnimationConfig(autoplay: true, loop: false)).view()
                Spacer()
                
                
                PrimaryButton(title: "I'm committed",
                              backgroundColor: Color.theme.macaw,
                ) {
                    nav.popToRoot()
                }
            }
            .padding()
          
        }
        .navigationBarBackButtonHidden(true)
      
    }
}

#Preview {
    let nav = NavigationManager()
    CurrencyRewardView()
        .environmentObject(nav)
}
