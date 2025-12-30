//
//  HomeTopHeader.swift
//  Shema
//
//  Created by Benson Arafat on 03/11/2025.
//

import SwiftUI

struct HomeTopHeader : View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var body: some View {
        // Header
        HStack {
            Text("Shema")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(colorScheme == .dark ? .white : .black)
            Spacer()
            
            HStack (spacing: 8) {
                HStack(spacing: 4) {
                    Text("🔥")
                    Text("9")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor( colorScheme == .dark ? .white : .black)
                }
                
                HStack {
                    
                  
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.red)
                    
                    Text("STOP")
                        .font(.fontNunitoRegular(size: 15))
                    

                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.red.opacity(0.5), lineWidth: 1)

                )
                                
            }
            
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}

#Preview {
    HomeTopHeader()
}
