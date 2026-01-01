//
//  OnboardingView.swift
//  Shema
//
//  Created by Benson Arafat on 30/12/2025.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @EnvironmentObject private var nav: NavigationManager
    
    var progress: CGFloat {
        CGFloat(currentPage + 1) / CGFloat(5)
    }
    
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            VStack (spacing: 0) {
                HStack (spacing: 16) {
                    
                    Button {
                        if currentPage > 0 {
                            withAnimation {
                                currentPage -= 1
                            }
                        } else {
                            nav.pop()
                        }
                            
                    } label:  {
                        Image(systemName: currentPage > 0 ? "chevron.left" : "xmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 18)
                            .foregroundColor(.theme.surfaceColor)
                        
                    }
                    
                    GeometryReader { geometry in
                        ZStack (alignment: .leading) {
                            
                            Rectangle()
                                .fill(Color.theme.surfaceColor)
                                .frame(height: 16)
                                .cornerRadius(40)
                            
                            Rectangle()
                                .fill(
                                    LinearGradient (colors: [
                                        .theme.primaryColor,
                                        .theme.secondaryColor,
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                    )
                                )
                                .frame(width: geometry.size.width * progress, height: 16)
                                .cornerRadius(40)
                                .animation(.easeInOut(duration: 0.3), value: currentPage)
                        }
                        
                    }
                }
                .frame(height: 16)
                Spacer()
                
                if currentPage == 0 {
                    IntroPage {
                        withAnimation {
                            currentPage += 1
                        }
                    }
                } else if (currentPage == 1) {
                    NotificationPermissionPage {
                        withAnimation {
                            currentPage += 1
                        }
                    }
                } else if (currentPage == 2) {
                    ScreenTimePermissionPage {
                        withAnimation {
                            currentPage += 1
                        }
                    }
                } else if ( currentPage == 3) {
                    SelectAppsPage {
                        withAnimation {
                            currentPage += 1
                        }
                    }
                } else  if (currentPage == 4) {
                    SelectReadTimePage()
                }
                
                Spacer()
                
                
            }
            .padding()
        }
      
        .navigationBarHidden(true)
    }
}

#Preview {
    let nav = NavigationManager()
    OnboardingView()
        .environmentObject(nav)
}
