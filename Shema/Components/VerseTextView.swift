//
//  VerseTextView.swift
//  Shema
//
//  Created by Benson Arafat on 21/11/2025.
//

import SwiftUI

struct VerseTextView: View {
    let verse: Verse
    var body: some View {
        
        VStack(spacing: 4) {
            HStack(alignment: .top, spacing: 4) {
                Text("\(verse.verse)")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .baselineOffset(4)
                
                Text(verse.cleanText)
                    .font(.body)
                    .foregroundColor(.primary)
                    .lineSpacing(8)

            }
            
            if let comment =  verse.comment, !comment.isEmpty {
                Text(comment)
                    .font(.fontNotoSansThin(size: 12))
                    .foregroundColor(.primary)
                    .padding(.leading, 12)
                 
            }
        }

    }
}

#Preview {
    VerseTextView(verse: Verse(
        pk: 36107, translation: "YLT", book: 18, chapter: 2, verse: 1, text: "And the day is, that sons of God come in to station themselves by Jehovah, and there doth come also the Adversary in their midst to station himself by Jehovah."
, comment: "And the day is, that sons of God come in to station themselves by Jehovah, and there doth come"

    ))
}
