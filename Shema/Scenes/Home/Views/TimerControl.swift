//
//  TimerControl.swift
//  Shema
//
//  Created by Benson Arafat on 03/11/2025.
//

import SwiftUI

struct TimerControl: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var body: some View {
        VStack (spacing: 16) {
            HStack (spacing: 8) {
                Button(action: {} ) {
                    Image(systemName: "minus")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor( colorScheme == .dark  ? .black : .white)
                        .frame(width: 50, height: 50)
                        .background(
                            colorScheme == .dark ?
                                .white : .black)
                        .clipShape(Circle())
                        
                }
                
                
                Text("20m")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor( colorScheme == .dark ? .black : .white)
                    .frame(maxWidth: 100)
                    .padding(.vertical,16)
                    .background( colorScheme == .dark ? .white : .black)
                    .cornerRadius(20)
                
                Button(action: {}) {
                    Image(systemName: "plus")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor( colorScheme == .dark  ? .black : .white)
                        .frame(width: 50, height: 50)
                        .background(
                            colorScheme == .dark ?
                                .white : .black)
                        .clipShape(Circle())
                }
                
                HStack (spacing: 2) {
                    Text("Blo...")
                        .foregroundColor(colorScheme == .dark  ? .black : .white)
                    HStack(spacing: 6) {
                        Text("📱")
                        Text("🌍")
                        Text("+10")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(colorScheme == .dark ? .black : .white)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                .background(colorScheme == .dark ? .white : .black)
                .cornerRadius(30)
            }.padding(.horizontal)
            
            Button(action: {} ) {
                HStack {
                    Image(systemName: "play.fill")
                    Text("Start Timer")
                        .font(.system(size: 18, weight: .semibold))
                }
                .foregroundColor(colorScheme == .dark ? .black : .white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(colorScheme == .dark ? .white : .black)
                .cornerRadius(20)
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 16)
    }
}


#Preview {
    TimerControl()
}
