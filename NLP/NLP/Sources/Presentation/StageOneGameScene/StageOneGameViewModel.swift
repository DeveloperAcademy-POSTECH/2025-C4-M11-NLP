//
//  StageOneGameViewModel.swift
//  NLP
//
//  Created by 양시준 on 7/14/25.
//

import SwiftUI

@MainActor
class StageOneGameViewModel: ViewModelable {
    struct State {
        var isPaused: Bool = false
        var isChatting: Bool = false
        var isFoundFlashlight: Bool = false
        var hasFlashlight: Bool = false
        var isFlashlightOn: Bool = false
    }
    
    enum Action {
        case findFlashlight
        case toggleFlashlight
    }
    
    @ObservedObject var coordinator: Coordinator
    
    @Published var state: State = State()
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
        case .findFlashlight:
            state.isFoundFlashlight = true
        case .toggleFlashlight:
            state.isFlashlightOn.toggle()
        }
    }
}
