//
//  Common+Extensions.swift
//  Shema
//
//  Created by Benson Arafat on 08/10/2025.
//

import Foundation


extension Date {
    func isInSameDay (as other: Date) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: other)
    }
    
    var readableDate: String {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: self)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, yyyy"
        
        return "\(day)\(daySuffix(day)) \(formatter.string(from: self))"
    }
    
    private func daySuffix(_ day: Int) -> String {
        switch day {
        case 11, 12, 13:
            return "th"
        default:
            switch day % 10 {
            case 1: return "st"
            case 2: return "nd"
            case 3: return "rd"
            default: return "th"
            }
        }
    }
}
