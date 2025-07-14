//
//  StartGameViewModel.swift
//  NLP
//
//  Created by Ted on 7/14/25.
//

import SwiftUI

@MainActor
class StartGameViewModel: ViewModelable {
    struct State {
        
    }
    
    enum Action {
        case textTapped
    }
    
    @ObservedObject var coordinator: Coordinator
    
    var state: State = State()
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
        case .textTapped:
            coordinator.push(.stageOneScene)
        }
    }
}
