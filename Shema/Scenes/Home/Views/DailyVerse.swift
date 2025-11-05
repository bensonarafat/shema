//
//  DailyVerse.swift
//  Shema
//
//  Created by Benson Arafat on 03/11/2025.
//

import SwiftUI

struct DailyVerse: View {
    @Environment(\.colorScheme) var colorScheme : ColorScheme
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Daily Referesh")
                .font(.fontNotoSansSemiBold(size: 14))
            .padding(.bottom, 16)
            
            VStack (alignment: .leading, spacing: 16)  {
                HStack {
                    Image(systemName: "book")
                    Text("Passage")
                        .font(.fontNotoSansSemiBold(size: 14))
                    
                    Spacer()
                    
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .foregroundColor(.blue)
                        
                }
                Text("Romans 12:3-6")
                    .font(.fontNotoSansBlack(size: 16))
                
                HStack {
                    Button  {
                        
                    }
                    label: {
                        Text("Listen")
                            .font(.fontNotoSansSemiBold(size: 14))
                            .foregroundColor(
                                colorScheme == .dark ?
                                    .black : .white)
                            .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .background(colorScheme == .dark ?
                                Color.white : Color(hex: "1c1c1e"))
                    .cornerRadius(20)
                    
                    Button  {
                        
                    }
                    label: {
                        Text("Read")
                            .font(.fontNotoSansSemiBold(size: 14))
                            .foregroundColor(
                                colorScheme == .dark ?
                                    .black : .white
                            )
                            .frame(maxWidth: .infinity)
                    } .padding()
                        .background(
                            colorScheme == .dark ?
                            Color.white : Color(hex: "1c1c1e"))
                        .cornerRadius(20)
                }
                
            }
            .padding()
            .background(
                colorScheme == .dark ?
                        Color(hex: "1c1c1e") : Color.white
            
            )
            .cornerRadius(16)
           
        }
        .padding()
    }
}


#Preview {
    DailyVerse()
}
