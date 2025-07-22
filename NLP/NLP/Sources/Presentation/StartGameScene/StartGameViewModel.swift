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
        case startButtonTapped
        case goStage1
        case goStage2
        case goStage3
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
        case .startButtonTapped:
            coordinator.push(.gameIntroScene)
        case .goStage1:
            coordinator.push(.stageOneScene)
        case .goStage2:
            coordinator.push(.stageTwoScene)
        case .goStage3:
            coordinator.push(.stageThreeScene)
        }
    }
}
