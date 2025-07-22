//
//  StageThreeViewModel.swift
//  NLP
//
//  Created by 양시준 on 7/22/25.
//

import SwiftUI

@MainActor
final class StageThreeViewModel: ViewModelable {
    struct State {
        var isTransitioning: Bool = true
        var isMonologuePresented: Bool = false
        var isItemCollecting: Bool = false
        var isDialogPresented: Bool = false
        var stageThreePhase: StageThreeMonologuePhase = .findFinn1
        
        var isTouchDisabled: Bool = false
    }
    
    enum Action {
        case transitionComplete
        case activateDialog(withNextPhase: Bool)
        case activateMonologue(withNextPhase: Bool)
        case deactivateDialog
        case deactivateMonologue
        case activateItemCollecting
        case goToNextPhase
        case goToPhase(to: StageThreeMonologuePhase)
        
        case fadeOutAndIn(withNextPhase: Bool)
        
        case disableTouch
        case activateTouch
    }
    
    @Published var state: State = .init()
    @ObservedObject var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
        case .transitionComplete:
            withAnimation(.linear(duration: 1)) {
                state.isTransitioning = false
            }
        case .activateDialog(let withNextPhase):
            state.isMonologuePresented = false
            state.isDialogPresented = true
            if withNextPhase {
                state.stageThreePhase = state.stageThreePhase.nextPhase ?? .lastPhase
            }
        case .activateMonologue(let withNextPhase):
            state.isDialogPresented = false
            state.isMonologuePresented = true
            if withNextPhase {
                state.stageThreePhase = state.stageThreePhase.nextPhase ?? .lastPhase
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
            state.stageThreePhase = state.stageThreePhase.nextPhase ?? .lastPhase
        case .goToPhase(let to):
            if state.stageThreePhase != to {
                state.stageThreePhase = to
            }
        case .fadeOutAndIn(let withNextPhase):
            Task {
                await MainActor.run {
                    withAnimation(.linear(duration: 1)) {
                        state.isTransitioning = true
                    }
                }
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                await MainActor.run {
                    withAnimation(.linear(duration: 1)) {
                        state.isTransitioning = false
                    }
                }
            }
            if withNextPhase {
                state.stageThreePhase = state.stageThreePhase.nextPhase ?? .lastPhase
            }
            
        case .disableTouch:
            state.isTouchDisabled = true
            
        case .activateTouch:
            state.isTouchDisabled = false
        }
    }
}
