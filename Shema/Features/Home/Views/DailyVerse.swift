//
//  DailyVerse.swift
//  Shema
//
//  Created by Benson Arafat on 03/11/2025.
//

import SwiftUI

struct DailyVerse: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Daily Referesh")
                .font(.fontNunitoRegular(size: 14))
                .foregroundColor(Color.theme.primaryTextColor)
                .fontWeight(.bold)
                .padding(.bottom, 4)
            
            VStack (alignment: .leading, spacing: 16)  {
                HStack {
                    Image(systemName: "book")
                        .foregroundColor(Color.theme.primaryTextColor)
                    Text("Passage")
                        .foregroundColor(Color.theme.primaryTextColor)
                        .font(.fontNunitoRegular(size: 14))
                    
                    Spacer()
                    
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .foregroundColor(Color.theme.primaryColor)
                        
                }
                Text("Romans 12:3-6")
                    .foregroundColor(Color.theme.primaryTextColor)
                    .font(.fontNunitoBlack(size: 16))
                
                HStack {
                    Button  {
                        
                    }
                    label: {
                        Text("Listen")
                            .font(.fontNunitoBold(size: 14))
                            .foregroundColor(Color.theme.primaryTextColor)
                            .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .background(Color(hex: "18221c"))
                    .cornerRadius(16)
                    
                    Button  {
                        
                    }
                    label: {
                        Text("Read")
                            .font(.fontNunitoBold(size: 14))
                            .foregroundColor(Color.theme.primaryTextColor)
                            .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .background(Color(hex: "18221c"))
                    .cornerRadius(16)
                       
                }
                
            }
            .padding()
            .background(
                Color(hex: "1c2923")
            )
            .cornerRadius(16)
           
        }
        .padding()
        .background(Color.theme.backgroundColor)
    }
}


#Preview {
    DailyVerse()
}
