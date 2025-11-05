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
            image: "first_light",
            description: "You completed your first Bible reading session."
        ),
        Badge(
            name: "Faithful Starter",
            image: "faithful_starter",
            description: "You read the Bible for 3 consecutive days."
        ),
        Badge(
            name: "Steady Spirit",
            image: "steady_spirit",
            description: "You maintained a 7-day Bible reading streak."
        ),
        Badge(
            name: "Devoted Disciple",
            image: "devoted_disciple",
            description: "You logged prayers for 7 days in a row."
        ),
        Badge(
            name: "Unbroken Chain",
            image: "unbroken_chain",
            description: "devoted_disciple"
        ),
        Badge(
            name: "Bible Marathoner",
            image: "bible_marthoner",
            description: "100-day reading streak."
        ),
        Badge(
            name: "Verse Collector",
            image: "verse_collector",
            description: "Saved 10 favorite verses."
        ),
        Badge(
            name: "Heart Keeper",
            image: "heart_keeper",
            description: "Memorized 5 verses."
        ),
        Badge(
            name: "Word Dweller",
            image: "word_dweller",
            description: "Memorized 20 verses."
        ),
        Badge(
            name: "Lamp to My Feet",
            image: "lamp_to_my_feet",
            description: "Highlighted 50 verses"
        ),
        Badge(
            name: "Quiet Time",
            image: "quite_time",
            description: "Logged first prayer."
        ),
        Badge(
            name: "prayer_warrior",
            image: "prayer_warrior",
            description: "Logged prayers for 7 consecutive days."
        ),
        Badge(
            name: "Faith in Action",
            image: "faith_in_action",
            description: "Shared a prayer or testimony."
        ),
        Badge(
            name: "Mountain Mover",
            image: "mountain_mover",
            description: "Completed 100 prayer entries."
        ),
        Badge(
            name: "Bible Student",
            image: "bible_student",
            description: "Completed first devotional."
        ),
    ]
}
