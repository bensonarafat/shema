//
//  IntroPage.swift
//  Shema
//
//  Created by Benson Arafat on 30/12/2025.
//

import SwiftUI

struct IntroPage: View {
    var onPressed: () -> Void
    
    var body: some View {
        
        VStack {
            Spacer()
            Text("Intro Page")
            Spacer()
            
            PrimaryButton(title: "Continue") {
                onPressed()
            }
          
        }
    
        
        
    }
}

#Preview {
    IntroPage {
        
    }
}
