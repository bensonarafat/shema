import Foundation

enum ReadTime: Int, Identifiable, CaseIterable, Codable, Equatable {
    case oneMinute = 1
    case threeMinutes = 3
    case fiveMinutes = 5
    case tenMinutes = 10
    case fifteenMinutes = 15
    case thirtyMinutes = 30

    var id: Int { rawValue }

    var minutes: Int {
        rawValue
    }

    var title: String {
        switch self {
        case .oneMinute:
            return "1 minute"
        case .threeMinutes:
            return "3 minutes"
        case .fiveMinutes:
            return "5 minutes"
        case .tenMinutes:
            return "10 minutes"
        case .fifteenMinutes:
            return "15 minutes"
        case .thirtyMinutes:
            return "30 minutes"
        }
    }
}
