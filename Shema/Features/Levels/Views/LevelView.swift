//
//  LevelView.swift
//  Shema
//
//  Created by Benson Arafat on 03/01/2026.
//

import SwiftUI

struct LevelView: View {
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                
                VStack (alignment: .leading, spacing: 0) {
                    Text("Emerald League")
                        .font(.fontNunitoBlack(size: 23))
                        .foregroundColor(Color.theme.primaryTextColor)
                    HStack (spacing: 4) {
                        Image(systemName: "clock.fill")
                        Text("6 hours")
                            .textCase(.uppercase)
                            .font(.fontNunitoBlack(size: 18))
                            
                    }
                    .foregroundColor(Color.gray)
                    
                    
                    ScrollView (.horizontal, showsIndicators: false)  {
                        HStack(alignment: .bottom) {
                            ForEach(League.all, id: \.self) { league in
                                Image(league.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: league.current ? 110 : 80,
                                           height:  league.current ? 110 : 80)
                                    .grayscale((league.passed || league.current) ? 0: 1)
                              
                            }
                        }
                    }
                }
               
                ScrollView (showsIndicators: false) {
                    VStack {
                        ForEach(1..<21) { i in
                            HStack (alignment: .center, spacing: 10) {
                                Text("\(i)")
                                    .font(.fontNunitoBold(size: 18))
                                    .padding(.horizontal, 8)
                                    .foregroundColor(Color.theme.secondaryColor)
                                
                                VStack {
                                    Text("G")
                                        .font(.fontNunitoBold(size: 20))
                                }
                                .padding()
                                .background(Circle()
                                    .fill(Color.theme.primaryColor))
                
                                
                                VStack (alignment: .leading){
                                    Text("Rocky Super")
                                        .font(.fontNunitoBold(size: 20))
                                    HStack  {
                                        Text("🌱")
                                        Text("20")
                                            .font(.fontNunitoBold(size: 16))
                                            .foregroundColor(Color.gray)
                                    }
                                   
                                }
                                .padding(.horizontal, 4)
                                
                                Spacer()
                                Text("217 XP")
                                    .font(.fontNunitoBold(size: 20))
                                    .foregroundColor(Color.gray)
                                
                            }.foregroundColor(Color.theme.primaryTextColor)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    LevelView()
}
