//
//  Coordinator.swift
//  NLP
//
//  Created by Ted on 7/14/25.
//

import SwiftUI

class Coordinator: ObservableObject {
    @Published var paths: [CoordinatorPath] = []
    
    
    func push(_ path: CoordinatorPath) {
        self.paths.append(path)
    }
    
    func pop() {
        _ = self.paths.popLast()
    }
}
