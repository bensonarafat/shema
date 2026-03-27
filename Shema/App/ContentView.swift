//
//  ContentView.swift
//  Shema
//
//  Created by Benson Arafat on 07/10/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
//    @EnvironmentObject var onboardingViewModel: OnboardingViewModel
    @EnvironmentObject var nav: AppRouter
//    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
//        NavigationStack (path: $nav.path){
//            Group {
//                
//               if authViewModel.isAuthenticated || authViewModel.hasCompleteAuthStep {
//                   AppNavigationBar()
//               } else {
//                   WelcomeView()
//               }
//            }
//            .background(Color.theme.backgroundColor)
//            .ignoresSafeArea(edges: .bottom)
//            .navigationDestination(for: AppDestination.self) { destination in
//                AppDestinationFactory.view(for: destination)
//            }
//        }
//        .task {
//            await authViewModel.refreshAuthToken()
//        }
//        .onChange(of: authViewModel.isAuthenticated) { oldValue, newValue in
//               if newValue && !oldValue {
//                   nav.popToRoot()
//               }
//        }
    }
//
//    private var loadingView: some View {
//           ZStack {
//               Color.theme.backgroundColor
//                   .ignoresSafeArea()
//               
//               ProgressView()
//                   .progressViewStyle(CircularProgressViewStyle(tint: .theme.primaryColor))
//                   .scaleEffect(1.5)
//           }
//       }

}

#Preview {
//    let vm = OnboardingViewModel()
    let nav = AppRouter()
//    let authVM = AuthViewModel()
    ContentView()
//        .environmentObject(vm)
        .environmentObject(nav)
//        .environmentObject(authVM)
}

