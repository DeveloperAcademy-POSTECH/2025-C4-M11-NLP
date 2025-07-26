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
        
        case goToEndingOneScene
        case goToEndingTwoScene
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
            Task {
                await startEpisodeTransitioning()
                await endEpisodeTransitioning()
            }
            
        case .dontGiveupKiridiumButtonTapped:
            state.phase = .endingTwoPartOne
            Task {
                await startEpisodeTransitioning()
                await endEpisodeTransitioning()
            }
            
        case .goToEndingOneScene:
            Task {
                await startEpisodeTransitioning()
                await MainActor.run {
                    coordinator.push(.middleStoryScene(.endingOne))
                }
            }
            
        case .goToEndingTwoScene:
            Task {
                await startEpisodeTransitioning()
                await MainActor.run {
                    coordinator.push(.middleStoryScene(.endingTwo))
                }
            }
        }
    }
    
    func startEpisodeTransitioning() async {
        state.isMonologuePresented = false
        state.blockViewTapAction = true
        
        withAnimation(.linear(duration: 2)) {
            state.isTransitioning = true
        }
        try? await Task.sleep(for: .seconds(2))
    }
    
    func endEpisodeTransitioning() async {
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

