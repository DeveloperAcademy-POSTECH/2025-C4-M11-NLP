//
//  StageOneIntroViewModel.swift
//  NLP
//
//  Created by Ted on 7/14/25.
//

import SwiftUI

class StageOneIntroViewModel: ViewModelable {
    struct State {
        var phase: Phase = .heartBeat
    }
    
    enum Action {
        case startButtonTapped
    }
    
    @Published var state: State = State()
    @ObservedObject var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
        case .startButtonTapped:
            coordinator.push(.stageOneScene)
        }
    }
    
    enum Phase {
        case heartBeat
        case introDialog
        case introDialogEnd
    }
}
