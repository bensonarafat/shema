//
//  LoadingContent.swift
//  Shema
//
//  Created by Benson Arafat on 22/11/2025.
//

import SwiftUI

struct LoadingContent: View {
    var body: some View {
        VStack {
            Spacer()
            ProgressView().foregroundColor(.primary)
            Spacer()
        }
    }
}

#Preview {
    LoadingContent()
}
