//
//  ProgressBar.swift
//  Shema
//
//  Created by Benson Arafat on 28/03/2026.
//

import SwiftUI

struct ProgressBar: View {
    let current: Int
    let total: Int
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 4)
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.primaryColorFeatherGreen)
                    .frame(width: geo.size.width * CGFloat(current) / CGFloat(total), height: 4)
                    .animation(.spring(), value: current)
            }
        }
        .frame(height: 4)
    }
}
