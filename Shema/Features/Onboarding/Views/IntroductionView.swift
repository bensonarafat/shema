//
//  IntroductionView.swift
//  Shema
//
//  Created by Benson Arafat on 28/03/2026.
//

import SwiftUI
import AVKit

struct IntroductionView: View {
    private let player = AVPlayer(url: Bundle.main.url(forResource: "onboarding", withExtension: "mp4")!)
    @EnvironmentObject var notificationManager: NotificationManager
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        ZStack {
            BackgroundVideoPlayer(player: player)
                .ignoresSafeArea()
            
            LinearGradient(
                gradient: Gradient(colors:[
                        Color.black.opacity(0.7),
                        Color.black.opacity(0.2),
                        Color.black.opacity(0.8)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Button {
                    player.pause()
                    router.pushOnboarding(AppRoute.onboarding)
                } label:  {
                    Text("Continue")
                        .font(.appButtonPrimary)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 50)
                                .fill(.primaryColorFeatherGreen)
                        )
                }
                
            }
            .padding()
        }
        .onAppear {
            player.play()
            Task {
                await notificationManager.requestPerimission()
            }
        }
        .onDisappear {
            player.pause()
            player.seek(to: .zero)
        }
    }
}

#Preview {
    IntroductionView()
        .environmentObject(NotificationManager())
        .environmentObject(AppRouter())
}
