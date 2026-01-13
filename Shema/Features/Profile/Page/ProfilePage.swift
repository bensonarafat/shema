//
//  ProfilePage.swift
//  Shema
//
//  Created by Benson Arafat on 05/01/2026.
//

import SwiftUI

struct ProfilePage: View {
    @EnvironmentObject var nav: NavigationManager
    @ObservedObject var profileViewModel: ProfileViewModel
    var  yearString : String {
          let year = Calendar.current.component(.year, from: profileViewModel.currentUser?.createdAt ?? Date())
          return String(year)
      }
    let columns : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    var body: some View {
        ScrollView {
            
            VStack (alignment: .leading, spacing: 12) {
                           
                HStack {
                    Text("\(profileViewModel.currentUser?.fullName ?? "")")
                        .font(.fontNunitoBlack(size: 18))
                        .foregroundColor(Color.theme.primaryTextColor)
                    
                    Spacer()
                    
                    
                }
                .padding(.horizontal)

                HStack (spacing: 4) {
                    Text("@\(profileViewModel.currentUser?.username ?? "")")
                        .textCase(.uppercase)
                        .font(.fontNunitoBlack(size: 12))
                        .foregroundColor(.gray)
                    
                    Image(systemName:"circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 4, height: 4)
                        .foregroundColor(.gray)
                    
                    Text("Joined \(yearString)")
                        .textCase(.uppercase)
                        .font(.fontNunitoBlack(size: 12))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                
                PrimaryButton(title: "Edit Profile") {
                    nav.push(AppDestination.editProfile(profileViewModel))
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
    }
}

#Preview {
    let nav = NavigationManager()
    let vm = ProfileViewModel()
    ProfilePage(profileViewModel:vm)
        .environmentObject(nav)
}
