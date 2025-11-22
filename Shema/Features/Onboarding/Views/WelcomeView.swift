//
//  WelcomeView.swift
//  Shema
//
//  Created by Benson Arafat on 29/10/2025.
//

import SwiftUI

struct WelcomeView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var nav : NavigationManager
    
    var body: some View {
            
    VStack () {
        Spacer()
        
        Text("Welcome to Shema")
        
            Button {
                nav.push(AppDestination.notifications)
            } label: {
                HStack {
                    Text("Get Started")
                        .font(.fontNotoSansBlack(size: 20))
                        .foregroundColor(
                            colorScheme == .dark ? .black :
                            .white)
                    Spacer()
                    Image(systemName: "chevron.forward")
                    
                }
                .padding(.vertical, 25)
                .padding(.horizontal, 25)
                .foregroundColor(
                    colorScheme == .dark ? .black  :
                        .white )
                .background(Color(
                    colorScheme == .dark ? .white :
                    .black))
                .cornerRadius(20)
                .padding()
            }
        
        }

    }
}

#Preview {
    var nav = NavigationManager()
    WelcomeView().environmentObject(nav);
}
