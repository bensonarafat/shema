//
//  BibleView.swift
//  Shema
//
//  Created by Benson Arafat on 19/10/2025.
//

import SwiftUI

struct BibleView: View {
    @EnvironmentObject var path: NavigationManager
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    let nav = NavigationManager()
    BibleView()
        .environmentObject(nav)
}
