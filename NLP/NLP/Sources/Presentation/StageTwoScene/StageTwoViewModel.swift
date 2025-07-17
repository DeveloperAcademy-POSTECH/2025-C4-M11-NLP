//
//  StageTwoViewModel.swift
//  NLP
//
//  Created by Ted on 7/15/25.
//

import SwiftUI

final class StageTwoViewModel: ViewModelable {
    struct State {
        var isMonologuePresented: Bool = false
        var isItemCollecting: Bool = false
        var isDialogPresented: Bool = false
        var stageTwoPhase: StageTwoMonologuePhase = .stageArrived
        
        var isTouchDisabled: Bool = false
    }
    
    enum Action {
        case robotEncountered
        case activateDialog(withNextPhase: Bool)
        case activateMonologue(withNextPhase: Bool)
        case deactivateDialog
        case deactivateMonologue
        case activateItemCollecting
        case goToNextPhase
        
        case disableTouch
    }
    
    @Published var state: State = .init()
    @ObservedObject var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
        case .robotEncountered:
            state.isMonologuePresented = true
        case .activateDialog(let withNextPhase):
            state.isItemCollecting = false
            state.isMonologuePresented = false
            state.isDialogPresented = true
            if withNextPhase {
                state.stageTwoPhase = state.stageTwoPhase.nextPhase ?? .lastPhase
            }
        case .activateMonologue(let withNextPhase):
            state.isDialogPresented = false
            state.isItemCollecting = false
            state.isMonologuePresented = true
            if withNextPhase {
                state.stageTwoPhase = state.stageTwoPhase.nextPhase ?? .lastPhase
            }
        case .deactivateDialog:
            state.isDialogPresented = false
            
        case .deactivateMonologue:
            state.isMonologuePresented = false
            
        case .activateItemCollecting:
            state.isDialogPresented = false
            state.isMonologuePresented = false
            state.isItemCollecting = true
        case .goToNextPhase:
            state.stageTwoPhase = state.stageTwoPhase.nextPhase ?? .lastPhase
        case .disableTouch:
            state.isTouchDisabled = true
        }
    }
}
