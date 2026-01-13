//
//  VerseTextView.swift
//  Shema
//
//  Created by Benson Arafat on 21/11/2025.
//

import SwiftUI

struct VerseTextView: View {
    let verse: Verse
    @Binding var isSelected: Bool
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 4,) {
            HStack(alignment: .top, spacing: 4) {
                Text("\(verse.verse).")
                    .font(.fontNunitoBold(size: 18))
                    .foregroundColor(.theme.primaryTextColor)
                    .baselineOffset(4)
                    .underline(isSelected, pattern: .dashDotDot, color: .primary)
                
                Text(verse.cleanText)
                    .font(.fontNunitoBold(size: 18))
                    .foregroundColor(Color.theme.primaryTextColor)
                    .lineSpacing(8)
                    .underline(isSelected, pattern: .dashDotDot, color: .primary)

            }
            
            
//            if let comment =  verse.comment, !comment.isEmpty {
//                Text(comment)
//                    .font(.fontNunitoBold(size: 18))
//                    .foregroundColor(.theme.primaryTextColor)
//                    .padding(.leading, 12)
//                    .underline(isSelected, pattern: .dashDotDot, color: .primary)
//                    .frame(minWidth: .infinity, alignment: .leading)
//                 
//            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
        .onTapGesture {
//            isSelected.toggle()
        }

    }
}

#Preview {
    VerseTextView(
       
        verse: Verse(
        pk: 36107, translation: "YLT", book: 18, chapter: 2, verse: 1, text: "And the day is, that sons of God come in to station themselves by Jehovah, and there doth come also the Adversary in their midst to station himself by Jehovah."
, comment: "And the day is, that sons of God come in to station themselves by Jehovah, and there doth come"

        ), isSelected: .constant(false))
}
