//
//  BibleAPIService.swift
//  Shema
//
//  Created by Benson Arafat on 09/10/2025.
//

import Foundation

class BibleAPIService {
    static let shared = BibleAPIService()
    
    func getTodayReading () -> BibleReading {
        let readings = [
            BibleReading (
                 book: "Psalms",
                 chapter: 23,
                 verses: "1-6",
                 content: """
                    The Lord is my shepherd; I shall not want.
                    
                    He makes me lie down in green pastures. He leads me beside still waters.
                    
                    He restores my soul. He leads me in paths of righteousness for his name's sake.
                    
                    Even though I walk through the valley of the shadow of death, I will fear no evil, for you are with me; your rod and your staff, they comfort me.
                    
                    You prepare a table before me in the presence of my enemies; you anoint my head with oil; my cup overflows.
                    
                    Surely goodness and mercy shall follow me all the days of my life, and I shall dwell in the house of the Lord forever.
                    
                    """,
            ),
            BibleReading(
                    book: "Proverbs",
                    chapter: 3,
                    verses: "5-6",
                    content: """
                    Trust in the Lord with all your heart, and do not lean on your own understanding.
                    
                    In all your ways acknowledge him, and he will make straight your paths.
                    """
                ),
                BibleReading(
                    book: "John",
                    chapter: 3,
                    verses: "16-17",
                    content: """
                    For God so loved the world, that he gave his only Son, that whoever believes in him should not perish but have eternal life.
                    
                    For God did not send his Son into the world to condemn the world, but in order that the world might be saved through him.
                    """
                )
        ]
        
        let dayOfYear = Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 1
        let index = dayOfYear % readings.count
        return readings[index]
    }
}
