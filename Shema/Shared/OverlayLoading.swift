//
//  OverlayLoading.swift
//  Shema
//
//  Created by Benson Arafat on 01/01/2026.
//

import SwiftUI

struct OverlayLoading: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            ProgressView()
                .scaleEffect(2)
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
        }
    }
}

#Preview {
    OverlayLoading()
}
