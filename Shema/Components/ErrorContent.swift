//
//  ErrorContent.swift
//  Shema
//
//  Created by Benson Arafat on 22/11/2025.
//

import SwiftUI

struct ErrorContent: View {
    @EnvironmentObject private var bibleViewModel: BibleViewModel
    
    let error: String
    var body: some View {
        VStack {
            Spacer()
            VStack (spacing: 12) {
                Image(systemName: "exclamationmark.triangle")
                    .font(.largeTitle)
                    .foregroundColor(.orange)
                Text(error)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                Button("Retry") {
                    bibleViewModel.loadChapter()
                }.buttonStyle(.borderedProminent)
            }
            .padding()
            Spacer()
        }
   
    }
}

#Preview {
    let vm = BibleViewModel()
    ErrorContent(error: "Oops, there was an error")
        .environmentObject(vm)
}
