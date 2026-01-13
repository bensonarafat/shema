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
    @EnvironmentObject var currencyViewModel: CurrencyViewModel
    
    let scripture: DailyScripture
    
    init (scripture: DailyScripture) {
        self.scripture = scripture
    }
    
    
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            VStack {
                DotLottieAnimation(fileName: "lottie_reward", config: AnimationConfig(autoplay: true, loop: false)).view()
                
                
                RewardCard(gems: scripture.gems, keys: scripture.keys)
                
                Spacer()

                
                VStack (spacing: 12) {
                    SecondaryButton (title: "Share with friends", customImage: "share") {
                        
                    }
                    
                    PrimaryButton(title: "I'm committed",
                                  backgroundColor: Color.theme.macaw,
                    ) {
                        nav.popToRoot()
                    }
                }
                

            }
            .padding()
            .onAppear{
                Task {
                    await currencyViewModel.addCurrency(value: scripture.gems, currencyType: CurrencyType.gem)
                    await currencyViewModel.addCurrency(value: scripture.keys, currencyType: CurrencyType.key)
                }
            }
          
        }
        .navigationBarBackButtonHidden(true)
      
    }
}
//
//#Preview {
//    let nav = NavigationManager()
//    CurrencyRewardView()
//        .environmentObject(nav)
//}
