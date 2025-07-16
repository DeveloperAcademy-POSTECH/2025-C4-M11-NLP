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
        var isDialogPresented: Bool = true
        var stageOnePhase: StageOneMonologuePhase = .stageArrived
        var isFoundFlashlight: Bool = false
        var hasFlashlight: Bool = false
        var isFlashlightOn: Bool = false
        var isMovingToCentralControlRoom: Bool = false
    }
    
    enum Action {
        case toggleDialogPresentation
        case findFlashlight
        case toggleFlashlight
        case moveToCenteralControlRoom
    }
    
    @ObservedObject var coordinator: Coordinator
    
    @Published var state: State = State()
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
        case .toggleDialogPresentation:
            state.isDialogPresented.toggle()
        case .findFlashlight:
            state.isFoundFlashlight = true
        case .toggleFlashlight:
            state.isFlashlightOn.toggle()
        case .moveToCenteralControlRoom:
            state.isMovingToCentralControlRoom = true
        }
    }
}
