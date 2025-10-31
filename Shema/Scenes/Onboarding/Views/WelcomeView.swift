//
//  WelcomeView.swift
//  Shema
//
//  Created by Benson Arafat on 29/10/2025.
//

import SwiftUI

struct WelcomeView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Binding var path : NavigationPath
    
    var body: some View {
            
    VStack () {
        Spacer()
        
        Text("Welcome to Shema")
        
            Button {
                path.append(AppDestination.notifications)
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
    WelcomeView(path: .constant(NavigationPath()))
}
