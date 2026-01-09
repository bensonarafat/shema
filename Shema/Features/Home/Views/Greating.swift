//
//  Greating.swift
//  Shema
//
//  Created by Benson Arafat on 03/11/2025.
//

import SwiftUI

struct Greating: View {
    
    @ObservedObject var viewModel: HomeViewModel
    @EnvironmentObject var scriptureService: ScriptureService
    
    var body: some View {
        HStack{
            Image(systemName: viewModel.greetings.icon)
                .font(.system(size: 14, weight: .bold))
            Text(scriptureService.scripture?.theme ?? viewModel.greetings.text)
                .textCase(.uppercase)
                .font(.fontNunitoBlack(size: 16))
                .fontWeight(.heavy)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)

    }
}

#Preview {
    let scriptureService = ScriptureService()
    Greating(
        viewModel: HomeViewModel()
    )
    .environmentObject(scriptureService)
}
