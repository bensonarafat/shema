//
//  Focus.swift
//  Shema
//
//  Created by Benson Arafat on 05/11/2025.
//

import Foundation

struct Focus: Codable, Identifiable, Hashable {
    let id: UUID
    let name: String
    let duration: Int
    let emoji: String
    let description: String
    let bibleVerses: [BibleVerse]?
    
    init(id: UUID = UUID(), name: String, duration: Int, emoji: String, description: String, bibleVerses: [BibleVerse] = [] ) {
        self.id = id
        self.name = name
        self.duration = duration
        self.emoji = emoji
        self.description = description
        self.bibleVerses = bibleVerses
    }
}

extension Focus {
    static let allFocuses: [Focus] = [
        Focus(
            name: "Faith",
            duration: 10,
            emoji: "🙏",
            description: "Strengthen your belief and trust in God through His promises.",
            bibleVerses: [
                BibleVerse(reference: "Hebrews 11:1", text: "Now faith is confidence in what we hope for and assurance about what we do not see.")
            ]
        ),
        Focus(
            name: "Gratitude",
            duration: 8,
            emoji: "🌅",
            description: "Reflect on the blessings in your life and thank God for them.",
            bibleVerses: [
                BibleVerse(reference: "1 Thessalonians 5:18", text: "Give thanks in all circumstances; for this is God's will for you in Christ Jesus.")
            ]
        ),
        Focus(
            name: "Peace",
            duration: 12,
            emoji: "☮️",
            description: "Calm your heart and find rest in the presence of the Holy Spirit.",
            bibleVerses: [
                BibleVerse(reference: "Philippians 4:7", text: "And the peace of God, which transcends all understanding, will guard your hearts and your minds in Christ Jesus.")
            ]
        ),
        Focus(
            name: "Hope",
            duration: 10,
            emoji: "🌈",
            description: "Renew your confidence in God's future plans for your life.",
            bibleVerses: [
                BibleVerse(reference: "Jeremiah 29:11", text: "For I know the plans I have for you, declares the Lord, plans to prosper you and not to harm you, plans to give you hope and a future.")
            ]
        ),
        Focus(
            name: "Love",
            duration: 15,
            emoji: "❤️",
            description: "Meditate on God’s unconditional love and how to show it to others.",
            bibleVerses: [
                BibleVerse(reference: "1 Corinthians 13:13", text: "And now these three remain: faith, hope and love. But the greatest of these is love.")
            ]
        ),
        Focus(
            name: "Forgiveness",
            duration: 10,
            emoji: "💧",
            description: "Learn to forgive others as Christ forgave you.",
            bibleVerses: [
                BibleVerse(reference: "Ephesians 4:32", text: "Be kind and compassionate to one another, forgiving each other, just as in Christ God forgave you.")
            ]
        ),
        Focus(
            name: "Obedience",
            duration: 10,
            emoji: "🙇‍♂️",
            description: "Focus on aligning your actions with God’s Word.",
            bibleVerses: [
                BibleVerse(reference: "John 14:15", text: "If you love me, keep my commands.")
            ]
        ),
        Focus(
            name: "Wisdom",
            duration: 12,
            emoji: "🕊️",
            description: "Seek divine wisdom for your decisions and life path.",
            bibleVerses: [
                BibleVerse(reference: "James 1:5", text: "If any of you lacks wisdom, you should ask God, who gives generously to all without finding fault, and it will be given to you.")
            ]
        ),
        Focus(
            name: "Patience",
            duration: 10,
            emoji: "⏳",
            description: "Wait on the Lord and trust His perfect timing.",
            bibleVerses: [
                BibleVerse(reference: "Romans 12:12", text: "Be joyful in hope, patient in affliction, faithful in prayer.")
            ]
        ),
        Focus(
            name: "Joy",
            duration: 8,
            emoji: "😊",
            description: "Rejoice in the Lord regardless of your circumstances.",
            bibleVerses: [
                BibleVerse(reference: "Nehemiah 8:10", text: "The joy of the Lord is your strength.")
            ]
        ),
        Focus(
            name: "Prayer",
            duration: 15,
            emoji: "🕯️",
            description: "Spend time talking to God and listening to His voice.",
            bibleVerses: [
                BibleVerse(reference: "Philippians 4:6", text: "Do not be anxious about anything, but in every situation, by prayer and petition, with thanksgiving, present your requests to God.")
            ]
        ),
        Focus(
            name: "Healing",
            duration: 12,
            emoji: "💖",
            description: "Focus on emotional, spiritual, and physical restoration in Christ.",
            bibleVerses: [
                BibleVerse(reference: "Isaiah 53:5", text: "By his wounds we are healed.")
            ]
        ),
        Focus(
            name: "Strength",
            duration: 10,
            emoji: "💪",
            description: "Find strength in God during moments of weakness or trial.",
            bibleVerses: [
                BibleVerse(reference: "Philippians 4:13", text: "I can do all this through him who gives me strength.")
            ]
        ),
        Focus(
            name: "Purpose",
            duration: 14,
            emoji: "🎯",
            description: "Reflect on your calling and why God created you.",
            bibleVerses: [
                BibleVerse(reference: "Romans 8:28", text: "And we know that in all things God works for the good of those who love him, who have been called according to his purpose.")
            ]
        ),
        Focus(
            name: "Renewal",
            duration: 9,
            emoji: "🌿",
            description: "Allow the Holy Spirit to renew your mind and refresh your soul.",
            bibleVerses: [
                BibleVerse(reference: "Romans 12:2", text: "Be transformed by the renewing of your mind.")
            ]
        ),
        Focus(
            name: "Trust",
            duration: 10,
            emoji: "🤝",
            description: "Surrender your worries and rely completely on God’s faithfulness.",
            bibleVerses: [
                BibleVerse(reference: "Proverbs 3:5", text: "Trust in the Lord with all your heart and lean not on your own understanding.")
            ]
        ),
        Focus(
            name: "Compassion",
            duration: 8,
            emoji: "🤍",
            description: "Open your heart to care deeply for others as Christ does.",
            bibleVerses: [
                BibleVerse(reference: "Colossians 3:12", text: "Clothe yourselves with compassion, kindness, humility, gentleness and patience.")
            ]
        ),
        Focus(
            name: "Discipline",
            duration: 11,
            emoji: "📖",
            description: "Stay consistent in prayer, study, and obedience.",
            bibleVerses: [
                BibleVerse(reference: "Hebrews 12:11", text: "No discipline seems pleasant at the time, but painful. Later on, however, it produces a harvest of righteousness and peace for those who have been trained by it.")
            ]
        ),
        Focus(
            name: "Humility",
            duration: 10,
            emoji: "🌾",
            description: "Learn to walk in humility, following Jesus’ example.",
            bibleVerses: [
                BibleVerse(reference: "Philippians 2:3", text: "Do nothing out of selfish ambition or vain conceit. Rather, in humility value others above yourselves.")
            ]
        ),
        Focus(
            name: "Courage",
            duration: 12,
            emoji: "🦁",
            description: "Be bold in faith and fearless in living out God’s truth.",
            bibleVerses: [
                BibleVerse(reference: "Joshua 1:9", text: "Be strong and courageous. Do not be afraid; do not be discouraged, for the Lord your God will be with you wherever you go.")
            ]
        )
    ]
}
