//
//  ProfilePage.swift
//  Shema
//
//  Created by Benson Arafat on 05/01/2026.
//

import SwiftUI

struct ProfilePage: View {
    @EnvironmentObject var nav: NavigationManager
    @StateObject var profileViewModel = ProfileViewModel()
    @State private var fullName = ""
    @State private var username = ""
    @State private var joined = Date()
    
    let columns : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    var body: some View {
        ScrollView {
            
            VStack (alignment: .leading, spacing: 12) {
                           
                HStack {
                    Text(fullName)
                        .font(.fontNunitoBlack(size: 18))
                        .foregroundColor(Color.theme.primaryTextColor)
                    
                    Spacer()
                    
                    
                }
                .padding(.horizontal)

                HStack (spacing: 4) {
                    Text("@\(username)")
                        .textCase(.uppercase)
                        .font(.fontNunitoBlack(size: 12))
                        .foregroundColor(.gray)
                    
                    Image(systemName:"circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 4, height: 4)
                        .foregroundColor(.gray)
                    
                    Text("Joined \(Calendar.current.component(.year, from: joined))")
                        .textCase(.uppercase)
                        .font(.fontNunitoBlack(size: 12))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                
                PrimaryButton(title: "Edit Profile") {
                    nav.push(AppDestination.editProfile)
                }
                .padding(.horizontal)
                .padding(.vertical, 12)
                
                
                VStack (alignment: .leading) {
                    Text("Overview")
                        .textCase(.uppercase)
                        .foregroundColor(.gray)
                        .font(.fontNunitoBlack(size: 16))
                  
                    LazyVGrid(columns: columns, alignment: .leading, spacing: 2, ) {
                        ForEach (profileViewModel.overviews, id: \.self) { overview in
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
        .onChange(of: profileViewModel.currentUser) { oldValue, newValue in
            if let user = newValue {
                fullName = user.fullName
                username = user.username
                joined = user.createdAt
            }
        }
    }
}

#Preview {
    let nav = NavigationManager()
    ProfilePage()
        .environmentObject(nav)
}
