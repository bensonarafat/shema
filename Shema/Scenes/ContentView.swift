//
//  ContentView.swift
//  Shema
//
//  Created by Benson Arafat on 07/10/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var viewModel: BibleLockViewModel
    
    var body: some View {
        Group {
            if !viewModel.hasCompletedOnboarding {
                OnboardingView()
            } else {
                HomeView()
            }
        }
    }

}

#Preview {
    ContentView()
}
