//
//  Greating.swift
//  Shema
//
//  Created by Benson Arafat on 03/11/2025.
//

import SwiftUI

struct Greating: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        HStack{
            Image(systemName: viewModel.greetings.icon)
                .font(.system(size: 14, weight: .bold))
            Text(viewModel.greetings.text)
                .font(.fontNunitoBlack(size: 16))
                .fontWeight(.heavy)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)

    }
}

#Preview {
    Greating(
        viewModel: HomeViewModel()
    )
}
