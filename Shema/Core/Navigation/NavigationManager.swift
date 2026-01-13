//
//  NavigationManager.swift
//  Shema
//
//  Created by Benson Arafat on 04/11/2025.
//

import Foundation
import Combine
import SwiftUI

class NavigationManager : ObservableObject {
    @Published var path = NavigationPath();
    
    
    func push<T: Hashable>(_ value: T) {
        path.append(value);
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot () {
        path.removeLast(path.count)
    }
    
    func replace(with destination: AppDestination) {
        if !path.isEmpty {
            path.removeLast()
        }
        path.append(destination)
    }
    
    var canGoBack: Bool {
        !path.isEmpty
    }
    
    // Get current path count
    var pathCount: Int {
        path.count
    }
}
