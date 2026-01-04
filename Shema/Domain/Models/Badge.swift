//
//  Badge.swift
//  Shema
//
//  Created by Benson Arafat on 03/11/2025.
//

import Foundation

struct Badge: Identifiable, Codable {
    let id: UUID
    let name: String
    let image: String
    let description: String
    var completed: Bool = false
    
    init(id: UUID = UUID(), name: String, image: String, description: String, completed: Bool = false) {
        self.id = id
        self.name = name
        self.image = image
        self.description = description
        self.completed = completed
    }
}


extension Badge {
    static let all: [Badge] = [
        Badge(
            name: "First Light",
            image: "1",
            description: "You completed your first Bible reading session."
        ),
        Badge(
            name: "Faithful Starter",
            image: "2",
            description: "You read the Bible for 3 consecutive days."
        ),
        Badge(
            name: "Steady Spirit",
            image: "3",
            description: "You maintained a 7-day Bible reading streak."
        ),
        Badge(
            name: "Devoted Disciple",
            image: "4",
            description: "You logged prayers for 7 days in a row."
        ),
        Badge(
            name: "Unbroken Chain",
            image: "5",
            description: "devoted_disciple"
        ),
        Badge(
            name: "Bible Marathoner",
            image: "6",
            description: "100-day reading streak."
        ),
        Badge(
            name: "Verse Collector",
            image: "7",
            description: "Saved 10 favorite verses."
        ),
        Badge(
            name: "Heart Keeper",
            image: "8",
            description: "Memorized 5 verses."
        ),
        Badge(
            name: "Word Dweller",
            image: "9",
            description: "Memorized 20 verses."
        ),
        Badge(
            name: "Lamp to My Feet",
            image: "10",
            description: "Highlighted 50 verses"
        ),
        Badge(
            name: "Quiet Time",
            image: "11",
            description: "Logged first prayer."
        ),
        Badge(
            name: "prayer_warrior",
            image: "12",
            description: "Logged prayers for 7 consecutive days."
        ),
        Badge(
            name: "Faith in Action",
            image: "13",
            description: "Shared a prayer or testimony."
        ),
        Badge(
            name: "Mountain Mover",
            image: "14",
            description: "Completed 100 prayer entries."
        ),
        Badge(
            name: "Bible Student",
            image: "15",
            description: "Completed first devotional."
        ),
    ]
}
