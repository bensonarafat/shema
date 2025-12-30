//
//  FocusView.swift
//  Shema
//
//  Created by Benson Arafat on 05/11/2025.
//

import SwiftUI

struct FocusView: View {
    var focus: Focus
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                Text(focus.emoji)
                    .font(.fontNunitoRegular(size: 150))
                    .frame(width: 250, height: 250)
                    .shadow(color: Color(.black), radius: 50)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
                Text(focus.name)
                    .font(.fontNunitoRegular(size: 18))
                Text(focus.description)
                    .font(.fontNunitoRegular(size: 16))
            }
            .padding()
            
            LazyVStack {
                ForEach(focus.bibleVerses ?? []) { verse in
                    ZStack {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(
                                colorScheme == .dark ?
                                Color(hex: "1c1c1e") : Color(hex: "ffffff")
                            )
                        HStack {
                            Text(verse.reference)
                                .font(.fontNunitoRegular(size: 16))
                        Spacer()
                            Image(systemName: "chevron.forward")
                                .foregroundColor(
                                    .secondary)
                        }
                        .padding(20)
                    }
                    .cornerRadius(16)
                }
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(focus.name)
    }
}

#Preview {
    FocusView(focus: Focus(name: "Faith", duration: 60, emoji: "", description: "Strengthen your belief and trust in God through His promises.", bibleVerses: [
        BibleVerse(reference: "Hebrews 11:1", text: "Now faith is confidence in what we hope for and assurance about what we do not see.")
    ]))
}
