//
//  HomeView.swift
//  Shema
//
//  Created by Benson Arafat on 10/10/2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: BibleLockViewModel
    
    var body: some View {
        ZStack (alignment: .bottom) {
            // Scrollable Content
            ScrollView {
                VStack (alignment: .leading, spacing: 24) {
                    HomeTopHeader()
                    
                    HStack{
                        Image(systemName: "sun.max")
                            .font(.system(size: 14, weight: .bold))
                        Text("GOOD MORNING")
                            .font(.system(size: 14, weight: .bold))
                    }.padding(.horizontal)
                    
                    // Daily Verses
                    DailyVerse()
                    // Bible Verses by Theme
                    BibleVersesByTheme()
                    
                    // Badge
                    Badges()
                    
                }
            }
            
            
        }
    }

    
}

#Preview {
    let vm = BibleLockViewModel()
    HomeView().environmentObject(vm)
}

struct DailyVerse: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Daily Referesh")
            .padding(.bottom, 16)
            
            VStack (alignment: .leading, spacing: 16)  {
                HStack {
                    Image(systemName: "book")
                    Text("Passage")
                    
                    Spacer()
                    
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .foregroundColor(.blue)
                        
                }
                Text("Romans 12:3-6")
                
                HStack {
                    Button  {
                        
                    }
                    label: {
                        Text("Listen")
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    
                    Button  {
                        
                    }
                    label: {
                        Text("Read")
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                    } .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                }
                
            }
            .padding()
            .background(Color(hex: "1c1c1e"))
            .cornerRadius(16)
           
        }
        .padding()
    }
}


struct Badges: View {
    
    var body:  some View {
        VStack {
            HStack {
                Text("Your Badge")
                Spacer()
                Button (action : {} ){
                    Image(systemName: "chevron.forward")
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct BibleVersesByTheme: View {
    
    var body: some View {
        VStack {
            HStack {
                Text("Theme Verses")
                Spacer()
                Button ( action : {} ) {
                    Image(systemName: "chevron.forward")
                        .foregroundColor(.black)
                }
                
            }.padding(.horizontal)
            ScrollView (.horizontal, showsIndicators: false) {
                HStack (spacing: 16) {
                    FocusTimerCard(
                      emoji: "🎯",
                      title: "Love",
                      duration: "20m",
                      backgroundImage: "sunset"
                  )
                    FocusTimerCard(
                         emoji: "🧑‍💼",
                         title: "Lust",
                         duration: "25m",
                         backgroundImage: "night"
                     )
                    FocusTimerCard(
                         emoji: "😊",
                         title: "Forgiveness",
                         duration: "25m",
                         backgroundImage: "night"
                     )
                }.padding(.horizontal)
            }
        }
        
    }
}


struct FocusTimerCard: View {
    let emoji: String
    let title: String
    let duration: String
    let backgroundImage: String
    
    var body: some View {
        ZStack (alignment: .leading) {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color(hex: "1c1c1e"))
            VStack (alignment: .leading, spacing: 8) {
                HStack (spacing: 8) {
                    Text(emoji)
                        .font(.system(size: 24))
                    Text(title)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.white)
                }
                Text(duration)
                    .font(.system(size: 16))
                
                Spacer()
                
                HStack(spacing: 8) {
                    Image(systemName: "play.fill")
                    Text("Start")
                        .font(.system(size: 16, weight: .medium))
                }
                .foregroundColor(.white)
            }.padding(20)
        }
        .frame(width: 180, height: 120)
        .cornerRadius(16)
    }
}

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
                        .font(.fontNotoSansBold(size: 15))
                    

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
