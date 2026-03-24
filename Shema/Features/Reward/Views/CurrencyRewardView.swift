//
//  RewardView.swift
//  Shema
//
//  Created by Benson Arafat on 09/01/2026.
//

import SwiftUI
import DotLottie

struct CurrencyRewardView: View {
    @EnvironmentObject var nav: AppRouter
    @EnvironmentObject var currencyViewModel: CurrencyViewModel
    @State private var rewarded = false
    
    let id: String
    
    init (id: String) {
        self.scripture = scripture
    }
    
    
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            VStack {
                DotLottieAnimation(fileName: "lottie_reward", config: AnimationConfig(autoplay: true, loop: false)).view()
                
                VStack(spacing: 8) {
                    Text("Well done! 🎉")
                        .font(.fontNunitoBlack(size: 30))
                        .fontWeight(.bold)
                        .foregroundStyle(Color.theme.secondaryTextColor)

                    Text("You’ve completed today’s scripture.\nEvery step of obedience draws you closer to God.")
                        .font(.fontNunitoBold(size: 18))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.theme.secondaryColor)
                }
                .padding(.top, 12)
                
                RewardCard(gems: scripture.gems, keys: scripture.keys)
                
                Spacer()

                
                VStack (spacing: 12) {
                    SecondaryButton (title: "Share with friends", customImage: "share") {
                        shareScripture()
                    }
                    
                    PrimaryButton(title: "I'm committed",
                                  backgroundColor: Color.theme.macaw,
                    ) {
                        // if coming from onboarding, let give the user the option to register
                        nav.popToRoot()
                        if scripture.fromOnboarding {
                            nav.push(AppDestination.registerNowLater(scripture.fromOnboarding))
                        }

                    }
                }
                

            }
            .padding()
            .onAppear{
                guard !rewarded else {return}
                rewarded = true
                
                Task {
                    await currencyViewModel.addCurrency(value: scripture.gems, currencyType: CurrencyType.gem)
                    await currencyViewModel.addCurrency(value: scripture.keys, currencyType: CurrencyType.key)
                }
            }
          
        }
        .navigationBarBackButtonHidden(true)
      
    }
    
    func shareScripture() {
        let message = """
            I just completed today’s scripture on Shema 🙏
            
            "\(scripture.theme)" - \(scripture.reference)
            
            Join me in building a daily habit with God. 
            """
        
        let activityVC = UIActivityViewController(activityItems: [message],
                                                  applicationActivities: nil)
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = scene.windows.first?.rootViewController {
            rootVC.present(activityVC, animated: true)
        }
    }
}
//
//#Preview {
//    let nav = NavigationManager()
//    CurrencyRewardView()
//        .environmentObject(nav)
//}
