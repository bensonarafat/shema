//
//  NetworkCardView.swift
//  Shema
//
//  Created by Benson Arafat on 05/01/2026.
//

import SwiftUI

struct NetworkCardView: View {
    var title: String
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            VStack( spacing: 8) {
                Image("offline")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                Text("\(title) are currently unavailable")
                    .font(.fontNunitoBlack(size: 24))
                    .foregroundColor(Color.theme.secondaryTextColor)
                Text("You seem to be offline. Check your connection or try a reading the scripture offline.")
                    .font(.fontNunitoBold(size: 18))
                    .foregroundColor(Color.gray)
            }
            .multilineTextAlignment(.center)
            .padding()
        }

        
    }
}

#Preview {
    NetworkCardView(title: "Profile")
}
