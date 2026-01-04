//
//  bibleReaderView.swift
//  Shema
//
//  Created by Benson Arafat on 10/10/2025.
//

import SwiftUI

struct BibleReaderView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var bibleViewModel: BibleViewModel
    
    var body: some View {
        VStack (spacing: 16) {
            // Top bar
            BibleViewTopbar()
            Divider()
            
            if bibleViewModel.isLoading {
                LoadingContent()
            } else if let error = bibleViewModel.error {
                ErrorContent(error: error)
            } else {
                BibleScrollAndControl()
            }
        }

        .foregroundColor(.white)
        .background(Color.theme.backgroundColor)
        .onAppear {
            if bibleViewModel.books.isEmpty {
                bibleViewModel.loadInitialData()
            }
        }
    }

    
}


#Preview {
    let vm = BibleViewModel()
    BibleReaderView().environmentObject(vm)
}

