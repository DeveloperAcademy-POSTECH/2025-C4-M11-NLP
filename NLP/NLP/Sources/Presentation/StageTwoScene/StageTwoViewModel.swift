//
//  StageTwoViewModel.swift
//  NLP
//
//  Created by Ted on 7/15/25.
//

import SwiftUI

@MainActor
final class StageTwoViewModel: ViewModelable {
    struct State {
        var isTransitioning: Bool = true
        var isMonologuePresented: Bool = false
        var isItemCollecting: Bool = false
        var isDialogPresented: Bool = false
        var stageTwoPhase: StageTwoMonologuePhase = .stageArrived
        
        var isTouchDisabled: Bool = false
        var hasMetBot: Bool = false // 로봇 최초 만남 여부
        var talkFailCount: Int = 0 // 대화 실패 횟수
        var talkChatCount: Int = 0 // 대화 채팅 시도 횟수
    }
    
    enum Action {
        case transitionComplete
        case robotEncountered
        case activateDialog(withNextPhase: Bool)
        case activateMonologue(withNextPhase: Bool)
        case deactivateDialog
        case deactivateMonologue
        case activateItemCollecting
        case goToNextPhase
        case goToMiddleStory
        
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
            
        case .robotEncountered:
            if !state.hasMetBot {
                state.isMonologuePresented = true
                state.stageTwoPhase = .meetBot
                state.hasMetBot = true
            } else {
                state.isDialogPresented = true
                state.isMonologuePresented = false
            }
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
        case .activateTouch:
            state.isTouchDisabled = false
        case .goToMiddleStory:
            Task {
                MusicManager.shared.playMusic(named: "bgm_5")
                withAnimation(.linear(duration: 1)) {
                    state.isTransitioning = true
                }
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                coordinator.push(.middleStoryScene(.stageTwoThree))
            }
        }
    }
}
