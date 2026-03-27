//
//  TermsText.swift
//  Shema
//
//  Created by Benson Arafat on 25/03/2026.
//

import SwiftUI

struct TermsText: View {
    var body: some View {
        Text(makeAttrivutedString())
            .font(.appFootnote)
            .multilineTextAlignment(.center)
            .foregroundColor(.gray)
            .padding(.top, 10)
            .padding(.horizontal)
    }
    
    private func makeAttrivutedString() -> AttributedString {
        var text = AttributedString("By continuing you agree to Shema's Terms and Conditions and Privacy Policy.")
        
        if let termsRange = text.range(of: "Terms and Conditions") {
            text[termsRange].link = URL(string: "https://tryshema.com/terms")
            text[termsRange].foregroundColor = .black
            text[termsRange].underlineStyle = .single
        }
        
        if let privacyRange = text.range(of: "Privacy Policy") {
            text[privacyRange].link = URL(string: "https://tryshema.com/privacy")
            text[privacyRange].foregroundColor = .black
            text[privacyRange].underlineStyle = .single
        }
        return text
    }
}


#Preview {
    TermsText()
}
