//
//  WelcomeView.swift
//  Shema
//
//  Created by Benson Arafat on 29/10/2025.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var nav : NavigationManager
    
    var body: some View {
            
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            
            VStack () {
                
                Spacer()
                
                VStack (spacing: 2)  {
                    Text("Shema")
                        .font(.fontNunitoExtraBold(size: 45))
                        .foregroundColor(Color.theme.primaryColor)
                        .fontWeight(.black)
                    Text("Hear God First")
                        .font(.fontNunitoBold(size: 16))
                        .foregroundColor(Color.theme.primaryTextColor)
                        .fontWeight(.heavy)
                }

                
                Spacer()
                
                VStack (spacing: 16) {
                   
                    PrimaryButton(title: "Get Started") {
                        nav.push(AppDestination.onboarding)
                    }

                    SecondaryButton(title: "I already have an account") {
                        nav.push(AppDestination.login)
                    }
                    
                }
                .padding(.horizontal)
                .padding(.bottom, 50)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            }
        .navigationBarBackButtonHidden(true)
        }
        

}

#Preview {
    var nav = NavigationManager()
    WelcomeView().environmentObject(nav);
}
