//
//  Level.swift
//  Shema
//
//  Created by Benson Arafat on 04/01/2026.
//

import Foundation

struct League : Hashable {
    let id: Int
    let image: String
    let name: String;
    var current: Bool = false;
    var passed: Bool = false;
}

extension League {
    
    static let all : [League] = [
        League(id: 1, image: "Amethyst", name: "Amethyst", passed: true),
        League(id: 2, image: "Bronze", name: "Bronze", passed: true),
        League(id: 3, image: "Diamond", name: "Diamond", passed: true),
        League(id: 4, image: "Emerald", name: "Emerald", current: true),
        League(id: 5, image: "Gold", name: "Gold"),
        League(id: 6, image: "Obsidian", name: "Obsidian"),
        League(id: 7, image: "Pearl", name: "Pearl"),
        League(id: 8, image: "Ruby", name: "Ruby"),
        League(id: 9, image: "Sapphire", name: "Sapphire"),
        League(id: 10, image: "Silver", name: "Silver"),
    ]
}
