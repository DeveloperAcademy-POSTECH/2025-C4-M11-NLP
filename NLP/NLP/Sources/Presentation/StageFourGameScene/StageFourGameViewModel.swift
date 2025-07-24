//
//  StageFourGameViewModel.swift
//  NLP
//
//  Created by Ted on 7/24/25.
//

import SwiftUI
import Combine

final class StageFourGameViewModel: ViewModelable {
    struct State {
        var phase: StageFourMonologuePhase = .recognizeSignalFromFuture
        var isMonologuePresented: Bool = false
        var blockViewTapAction: Bool = false
        var isTransitioning: Bool = false
        var skip: Bool = false
    }
    
    enum Action {
        case activateMonologue
        case saveEarthButtonTapped
        case dontGiveupKiridiumButtonTapped
    }
    
    @Published var state: State = State()
    @ObservedObject var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
        case .activateMonologue:
            state.isMonologuePresented = true
            
        case .saveEarthButtonTapped:
            state.phase = .endingOnePartOne
            startEpisodeTransitioning()
            
        case .dontGiveupKiridiumButtonTapped:
            state.phase = .endingTwoPartOne
            startEpisodeTransitioning()
        }
    }
    
    func startEpisodeTransitioning() {
        state.isMonologuePresented = false
        state.blockViewTapAction = true
        
        Task {
            withAnimation(.linear(duration: 2)) {
                state.isTransitioning = true
            }
            try? await Task.sleep(for: .seconds(2))
            
            withAnimation(.linear(duration: 2)) {
                state.isTransitioning = false
            }
            try? await Task.sleep(for: .seconds(2))
            
            await MainActor.run {
                state.isMonologuePresented = true
                state.blockViewTapAction = false
            }
        }
    }
}

