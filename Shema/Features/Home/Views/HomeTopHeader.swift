//
//  HomeTopHeader.swift
//  Shema
//
//  Created by Benson Arafat on 03/11/2025.
//

import SwiftUI

struct HomeTopHeader : View {
 
    var body: some View {
        // Header
        HStack {
            
            GeometryReader { geo in
                HStack(spacing: 8) {
                    Text("🔑")
                        .font(.fontNunitoBlack(size: 20))
                        
                    Text("10")
                        .font(.fontNunitoBlack(size: 20))
                        .foregroundColor(Color.theme.primaryTextColor)
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }

            GeometryReader { geo in
                HStack(spacing: 8) {
                    Text("🌱")
                        .font(.fontNunitoBlack(size: 20))
                    Text("100")
                        .font(.fontNunitoBlack(size: 20))
                        .foregroundColor(Color.theme.primaryTextColor)
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
            
            GeometryReader { geo in
                HStack(spacing: 8) {
                    Image("streak")
                        
                    Text("400")
                        .font(.fontNunitoBlack(size: 20))
                        .foregroundColor(Color.theme.primaryTextColor)
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
            
            GeometryReader { geo in
                HStack(spacing: 8) {
                    Image("gem")
                    Text("20")
                        .font(.fontNunitoBlack(size: 20))
                        .foregroundColor(Color.theme.primaryTextColor)
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
            
        }
        .frame(height: 20)
        .padding(8)
        .background(Color.theme.backgroundColor)
    }
}

#Preview {
    HomeTopHeader()
}
