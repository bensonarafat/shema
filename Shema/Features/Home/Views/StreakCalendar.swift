//
//  StreakCalendar.swift
//  Shema
//
//  Created by Benson Arafat on 03/01/2026.
//

import SwiftUI

struct StreakCalendar: View {
    @EnvironmentObject var streakViewModel: StreakViewModel
    @State private var selectedDate = Date()
    @State private var currentWeekIndex = 3
    
    private let calendar = Calendar.current
    
    // Generate list of weeks, each containing 7 dates
    private var weeks: [[Date]] {
        let today = calendar.startOfDay(for: Date())
        
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))!
        
        return (-3...3).map { weekOffset in
            (0..<7).compactMap { dayOffset in
                calendar.date(byAdding: .day, value: dayOffset + weekOffset * 7, to: startOfWeek)
            }
        }
    }
    
    var body: some View {
            TabView (selection: $currentWeekIndex) {
                ForEach (weeks.indices, id: \.self) { weekIndex in
                    HStack (spacing: 16) {
                        ForEach (weeks[weekIndex], id: \.self) { date in
                            let isSelected = calendar.isDate(date, inSameDayAs: selectedDate)
                            GeometryReader { geo in
                                VStack {
                                    Text(dayAbbreviation(for: date))
                                        .font(.fontNunitoBold(size: 14))
                                        .foregroundColor(Color.theme.primaryTextColor)
                                    
                                    Text("\(calendar.component(.day, from: date))")
                                        .font(.fontNunitoBold(size: 14))
                                        .foregroundColor(isSelected ? Color.black : Color.theme.primaryTextColor)
                                        .frame(width: 35, height: 35)
                                        .background(
                                            Circle()
                                                .fill(isSelected ? Color(hex: "f49000") : .clear )
                                        )
                                   
                                    if streakViewModel.streaks.contains(where: { streak in
                                        streak.date.isInSameDay(as: date)
                                    }) {
                                        Circle()
                                            .fill(Color(hex: "f49000"))
                                            .frame(width: 8, height: 8)
                                    }
                                   
                                }
                                .frame(width: geo.size.width, height: geo.size.height)
                                .contentShape(Rectangle())
                                .onTapGesture {
//                                    selectedDate = date
                                }
                            }
                            
                        }
                    }
                    .padding(.horizontal)
                    .tag(weekIndex)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 100)
            .animation(.easeInOut, value: currentWeekIndex)
            .background(Color(hex: "1c2923"))
            .cornerRadius(16)
    }
    
    
    private func dayAbbreviation(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "E"
        return String(formatter.string(from: date).prefix(1))
    }
}

#Preview {
    let streakViewModel = StreakViewModel()
    StreakCalendar()
        .environmentObject(streakViewModel)
}
