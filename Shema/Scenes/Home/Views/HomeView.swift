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
                    // Header
                    HStack {
                        Text("Shema")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.black)
                        Spacer()
                        
                        HStack (spacing: 12) {
                            HStack(spacing: 4) {
                                Text("🔥")
                                Text("9").foregroundColor(.black)
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
                            .background(Color.green.opacity(0.2))
                            .cornerRadius(20)
                            
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.black)
                                .font(.system(size: 20))
                        }
                        
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                }
            }
            
            // Fixed Timer Control at Bottom
            TimerControl()
            
        }
//        .ignoresSafeArea()
    }
//    var body: some View {
//        NavigationView {
//            VStack (spacing: 30) {
//                // Status Card
//                statusCard
//                
//                // Today's Reading Card
//                if let reading = viewModel.currentReading {
//                    readingCard(reading: reading)
//                }
//                
//                Spacer()
//                
//                // Stats
//                
//                statsSection
//            }
//            .padding()
//            .navigationTitle("Shema")
//            .toolbar {
//                Button {
//                    showingSettings = true
//                } label : {
//                    Image(systemName: "gearshape")
//                }
//            }
//            .sheet(isPresented: $showingSettings) {
//                SettingsView()
//            }
//            
//        }
//    }
    
//    var statusCard: some View {
//        VStack(spacing: 15) {
//            Image(systemName: viewModel.readingProgress.hasCompletedTodaysReading ? "checkmark.circle.fill" : "lock.fill")
//                .font(.system(size: 60))
//                .foregroundColor(viewModel.readingProgress.hasCompletedTodaysReading ? .green : .orange)
//            
//            Text(viewModel.readingProgress.hasCompletedTodaysReading ? "Reading Complete!" : "Apps Locked")
//                .font(.title2)
//                .fontWeight(.bold)
//            
//            Text(viewModel.readingProgress.hasCompletedTodaysReading ? "Your apps are unlocked for today" : "Complete your Bible reading to unlock")
//                .font(.subheadline)
//                .foregroundColor(.secondary)
//                .multilineTextAlignment(.center)
//        }
//        .frame(maxWidth: .infinity)
//        .padding()
//        .background(
//            RoundedRectangle(cornerRadius: 15)
//                .fill(viewModel.readingProgress.hasCompletedTodaysReading ? Color.green.opacity(0.1) : Color.orange.opacity(0.1))
//        )
//    }
//    
//    func readingCard(reading: BibleReading) -> some View {
//        NavigationLink (destination: BibleReaderView()) {
//            VStack(alignment: .leading, spacing: 10) {
//                HStack {
//                    Image(systemName: "book.fill")
//                        .foregroundColor(.blue)
//                    
//                    Text("Today's Reading")
//                        .font(.headline)
//                    
//                    Spacer()
//                    Image(systemName: "chevron.right")
//                        .foregroundColor(.secondary)
//                }
//                
//                Text("\(reading.book) \(reading.chapter): \(reading.verses)")
//                    .font(.title3)
//                    .fontWeight(.semibold)
//                
//                if !viewModel.readingProgress.hasCompletedTodaysReading {
//                    Text("Tap to start reading")
//                        .font(.subheadline)
//                        .foregroundColor(.secondary)
//                }
//            }
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .padding()
//            .background(
//                RoundedRectangle(cornerRadius: 15)
//                    .fill(Color.blue.opacity(0.1))
//            )
//        }
//        .buttonStyle(PlainButtonStyle())
//    }
//    
//    var statsSection: some View {
//        VStack (spacing: 15) {
//            Text("Your progress")
//                .font(.headline)
//                .frame(maxWidth: .infinity, alignment: .leading)
//            
//            HStack (spacing: 20) {
//                StatBox(
//                    icon: "flame.fill",
//                    value: "\(viewModel.readingProgress.currentStreak)",
//                    label: "Day Streak",
//                    color: .orange
//                )
//            }
//            
//            StatBox(
//                icon: "checkmark.circle.fill",
//                value: "1",
//                label: "Total Reads",
//                color: .green
//            )
//        }
//    }
}

#Preview {
    let vm = BibleLockViewModel()
    HomeView().environmentObject(vm)
}

struct TimerControl: View {
    var body: some View {
        VStack (spacing: 16) {
            HStack (spacing: 8) {
                Button(action: {} ) {
                    Image(systemName: "minus")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Color.black)
                        .clipShape(Circle())
                        
                }
                
                
                Text("20m")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: 100)
                    .padding(.vertical,16)
                    .background(Color.black)
                    .cornerRadius(20)
                
                Button(action: {}) {
                    Image(systemName: "plus")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: 50,height: 50)
                        .background(Color.black)
                        .clipShape(Circle())
                }
                
                HStack (spacing: 2) {
                    Text("Blo...")
                        .foregroundColor(.white)
                    HStack(spacing: 6) {
                        Text("📱")
                        Text("🌍")
                        Text("+10")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                .background(Color.black)
                .cornerRadius(30)
            }.padding(.horizontal)
            
            Button(action: {} ) {
                HStack {
                    Image(systemName: "play.fill")
                    Text("Start Timer")
                        .font(.system(size: 18, weight: .semibold))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(    Color.black)
                .cornerRadius(20)
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 16)
//        .background(
//            LinearGradient(colors: [Color(red: 0.1, green: 0.15, blue: 0.15).opacity(0), Color(red: 0.1, green: 0.15, blue: 0.15)], startPoint: .top, endPoint: .bottom)
//        )
    }
}
//
//
//struct StatBox: View {
//    let icon: String
//    let value: String
//    let label: String
//    let color: Color
//    
//    var body: some View {
//        VStack (spacing: 10) {
//            Image(systemName: icon)
//                .font(.title)
//                .foregroundColor(color)
//            
//            Text(value)
//                .font(.title2)
//                .fontWeight(.bold)
//            
//        }
//        .frame(maxWidth: .infinity)
//        .padding()
//        .background(
//            RoundedRectangle(cornerRadius: 10)
//                .fill(color.opacity(0.1))
//        )
//    }
//}
