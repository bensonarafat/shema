//
//  HomeTopHeader.swift
//  Shema
//
//  Created by Benson Arafat on 03/11/2025.
//

import SwiftUI

struct HomeTopHeader : View {
 
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @EnvironmentObject var currencyViewModel: CurrencyViewModel
    @EnvironmentObject var streakViewModel: StreakViewModel
    
    var body: some View {
        
        VStack {
            if  !networkMonitor.isConnected {
                // Network
                HStack (spacing: 6) {
                    Image(systemName: "icloud.slash")
                    Text("you are offline")
                        .textCase(.uppercase)
                        .foregroundColor(Color.theme.primaryTextColor)
                        .font(.fontNunitoBlack(size: 14))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(Color.black.opacity(0.5))
                
            }
            // Header
            HStack {
                GeometryReader { geo in
                    HStack(spacing: 8) {
                        Image("key")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            
                        Text("\(currencyViewModel.currency.key)")
                            .font(.fontNunitoBlack(size: 20))
                            .foregroundColor(Color.theme.primaryTextColor)
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                }

                
                GeometryReader { geo in
                    HStack(spacing: 8) {
                        Image("gem")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                        Text("\(currencyViewModel.currency.gem)")
                            .font(.fontNunitoBlack(size: 20))
                            .foregroundColor(Color.theme.primaryTextColor)
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                }
                
             
                GeometryReader { geo in
                    HStack(spacing: 8) {
                        Image("streak")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                        
                        Text("\(streakViewModel.streaks.count)")
                            .font(.fontNunitoBlack(size: 20))
                            .foregroundColor(Color.theme.primaryTextColor)
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                }
                
                GeometryReader { geo in
                    HStack(spacing: 8) {
                        Image("xp")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                        Text("\(currencyViewModel.currency.xp)")
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
}

#Preview {
    let networkMonitor = NetworkMonitor.shared
    let currencyViewModel = CurrencyViewModel()
    let streakViewModel = StreakViewModel()
    HomeTopHeader()
        .environmentObject(networkMonitor)
        .environmentObject(currencyViewModel)
        .environmentObject(streakViewModel)
}
