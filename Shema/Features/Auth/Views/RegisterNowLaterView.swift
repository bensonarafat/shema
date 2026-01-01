//
//  RegisterNowLaterView.swift
//  Shema
//
//  Created by Benson Arafat on 31/12/2025.
//

import SwiftUI

struct RegisterNowLaterView: View {
    @EnvironmentObject private var nav: NavigationManager
    @EnvironmentObject private var authViewModel: AuthViewModel
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                VStack (spacing: 16) {
                    PrimaryButton(title: "create profile") {
                        nav.push(AppDestination.register)
                    }
                    
                    SecondaryButton(title: "later", borderColor: Color.clear) {
                        authViewModel.completeAuthStep()
                        nav.popToRoot()
                        nav.push(AppDestination.tabs)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    let vm = AuthViewModel()
    let nav = NavigationManager()
    RegisterNowLaterView()
        .environmentObject(vm)
        .environmentObject(nav)
}
