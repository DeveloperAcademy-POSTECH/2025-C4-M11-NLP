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
        paths.append(path)
    }
    
    func pop() {
        _ = paths.popLast()
    }
    
    func popAll() {
        paths.removeAll()
    }
    
    func popToRoot() {
        let root = paths.first
        guard let root = root else { return }
        paths.removeAll()
        paths.append(root)
    }
}
