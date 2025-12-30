//
//  SelectedVerseSheet.swift
//  Shema
//
//  Created by Benson Arafat on 27/11/2025.
//

import SwiftUI

struct SelectedVerseSheet: View {
    var body: some View {
        ScrollView (.horizontal, showsIndicators: false) {
            HStack (spacing: 8) {

                
            ScrollView  (.horizontal, showsIndicators: false){
                HStack {
                    ForEach(1..<4) { _ in
                        Image(systemName: "circle.fill")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.red)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                    }
                }
                .padding(13)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex: "353233"))
                    )
            }
            Image("ai")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.white)
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(hex: "353233"))
                )

                
                VStack {
                    Image(systemName: "bookmark")
                    Text("Save")
                }.padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex: "353233"))
                    )
                
                VStack {
                    Image(systemName: "document.on.document")
                    Text("Copy")
                }.padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex: "353233"))
                    )
                VStack {
                    Image(systemName: "square.and.arrow.up")
                    Text("Share")
                }.padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex: "353233"))
                    )
            }

        }
        .padding()
    }
}

#Preview {
    SelectedVerseSheet()
}

