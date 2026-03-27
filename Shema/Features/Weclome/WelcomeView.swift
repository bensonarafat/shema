//
//  WelcomeView.swift
//  Shema
//
//  Created by Benson Arafat on 29/10/2025.
//

import SwiftUI
import AVKit

struct WelcomeView: View {
    @EnvironmentObject var router : AppRouter
    @State private var showSheet: Bool = false
    
    private let player = AVPlayer(url: Bundle.main.url(forResource: "welcome", withExtension: "mp4")!)
    
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
                    showSheet = true
                } label:  {
                    Text("Get started")
                        .font(.appButtonPrimary)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 24)
                        .padding(.horizontal, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 50)
                                .fill(.primaryColorFeatherGreen)
                        )
                }
             
            }
            .padding()
        }
        .sheet(isPresented: $showSheet) {
            SignInSheet()
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(40)
                .presentationContentInteraction(.scrolls)
                .ignoresSafeArea()
        }
    
    }
        

}

#Preview {
    WelcomeView()
        .environmentObject(AppRouter())
}




