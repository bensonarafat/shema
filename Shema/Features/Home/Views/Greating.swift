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
                .font(.fontNunitoRegular(size: 15))
        }.padding(.horizontal)

    }
}

#Preview {
    Greating(
        viewModel: HomeViewModel()
    )
}
