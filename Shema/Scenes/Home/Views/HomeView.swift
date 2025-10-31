//
//  HomeView.swift
//  Shema
//
//  Created by Benson Arafat on 10/10/2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: BibleLockViewModel
    //    @State private var showingSettings = false
    
    var body: some View {
        ZStack (alignment: .bottom) {
            // Scrollable Content
            ScrollView {
                VStack (alignment: .leading, spacing: 24) {
                    HomeTopHeader()
                    
                    HStack{
                        Image(systemName: "sun.max")
                            .font(.system(size: 14, weight: .bold))
                        Text("GOOD MORNING, BENSON")
                            .font(.system(size: 14, weight: .bold))
                    }.padding(.horizontal)
                    
                    // Bible Verses by Theme
                    BibleVersesByTheme()
                    
                    // Badge
                    Badges()
                    
                }
            }
            
            // Fixed Timer Control at Bottom
            TimerControl()
            
        }
    }

    
}

#Preview {
    let vm = BibleLockViewModel()
    HomeView().environmentObject(vm)
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
                .fill(
                    LinearGradient(
                        colors: backgroundImage == "sunset"
                        ?
                        [Color.orange.opacity(0.6), Color.orange.opacity(0.3)] :
                                                  [Color.blue.opacity(0.6), Color.purple.opacity(0.4)],
                        startPoint: .topLeading, endPoint: .bottomTrailing
                    )
                )
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
            
            HStack (spacing: 12) {
                HStack(spacing: 4) {
                    Text("🔥")
                    Text("9")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor( colorScheme == .dark ? .white : .black)
                }
                
                HStack (spacing: 4) {
                    Image(systemName: "bolt.fill")
                        .foregroundColor(.green)
                    Text("Get PRO")
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .semibold))
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            colorScheme == .dark ?
                            .black.opacity(0.8)
                            : .green.opacity(0.2)
                            ,
                            colorScheme == .dark ?
                                .blue.opacity(0.5)
                            :    .blue.opacity(0.8)
                        ] ),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(20)
                
                Image(systemName: "square.and.arrow.up")
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                colorScheme == .dark ?
                                .white.opacity(0.8)
                                : .black.opacity(0.9)
                                ,
                                colorScheme == .dark ?
                                    .blue.opacity(0.9)
                                :    .blue.opacity(0.8)
                            ] ),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .font(.system(size: 25))
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
