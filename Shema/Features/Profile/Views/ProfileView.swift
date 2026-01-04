//
//  ProfileView.swift
//  Shema
//
//  Created by Benson Arafat on 03/01/2026.
//

import SwiftUI

struct ProfileView: View {
    
    let columns : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            ScrollView {
                
                VStack (alignment: .leading, spacing: 12) {
                               
                    HStack {
                        Text("Benson Arafat")
                            .font(.fontNunitoBlack(size: 18))
                            .foregroundColor(Color.theme.primaryTextColor)
                        
                        Spacer()
                        
                        
                    }
                    .padding(.horizontal)

                    HStack (spacing: 4) {
                        Text("@bensonarafat")
                            .textCase(.uppercase)
                            .font(.fontNunitoBlack(size: 12))
                            .foregroundColor(.gray)
                        
                        Image(systemName:"circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 4, height: 4)
                            .foregroundColor(.gray)
                        
                        Text("Joined 2019")
                            .textCase(.uppercase)
                            .font(.fontNunitoBlack(size: 12))
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    
                    PrimaryButton(title: "Edit Profile") {
                        
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    
                    
                    VStack (alignment: .leading) {
                        Text("Overview")
                            .textCase(.uppercase)
                            .foregroundColor(.gray)
                            .font(.fontNunitoBlack(size: 16))
                      
                        LazyVGrid(columns: columns, alignment: .leading, spacing: 2, ) {
                            ForEach (Overview.all, id: \.self) { overview in
                                HStack (spacing: 8) {
                                    Image(overview.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                    
                                    Text(overview.value)
                                        .font(.fontNunitoBold(size: 16))
                                        .foregroundColor(Color.theme.primaryTextColor)
                                }
                                .padding(8)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    //Badge
                   BadgeGridView()

                }
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
   
    }
}

#Preview {
    ProfileView()
}
