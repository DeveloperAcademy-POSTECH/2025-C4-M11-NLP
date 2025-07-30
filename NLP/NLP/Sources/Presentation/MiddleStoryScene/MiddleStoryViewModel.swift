//
//  StageOneTwoMiddleStoryViewModel.swift
//  NLP
//
//  Created by Ted on 7/18/25.
//

import SwiftUI

final class MiddleStoryViewModel: ViewModelable {
    struct State {
        var isTransitioning: Bool = false
        var storiesType: StoriesType
        var storyIndex: Int = 0
        
        var isPreviousAvailable: Bool = false
        var isNextAvailable: Bool = true
    }
    
    enum Action {
        case goToPreviousStory
        case goToNextStory
    }
    
    @Published var state: State
    @ObservedObject var coordinator: Coordinator
    
    init(
        coordinator: Coordinator,
        storiesType: StoriesType
    ) {
        self.coordinator = coordinator
        self.state = State(storiesType: storiesType)
    }
    
    func action(_ action: Action) {
        switch action {
        case .goToPreviousStory:
            if state.storyIndex > 0 {
                state.storyIndex -= 1
                state.isNextAvailable = true
            }
            if state.storyIndex == 0 {
                state.isPreviousAvailable = false
            }
            
        case .goToNextStory:
            // 뒤에 스토리가 더 있다면
            if state.storyIndex < state.storiesType.stories.count - 1 {
                state.storyIndex += 1
                state.isPreviousAvailable = true
                return
            }
            
            // 스토리의 마지막이라면
            Task {
                await MainActor.run {
                    withAnimation(.linear(duration: 1)) {
                        state.isTransitioning = true
                    }
                }
                try? await Task.sleep(nanoseconds: 1_000_000_000)

                switch state.storiesType {
                case .stageOneTwo:
                    coordinator.push(.stageTwoScene)
                case .stageTwoThree:
                    coordinator.push(.stageThreeScene)
                case .stageThreeFour:
                    coordinator.push(.stageFourScene)
                    
                case .endingOne:
                    await MusicManager.shared.playMusic(named: "bgm_ending")
                    coordinator.push(.endingCreditScene)
                    break
                case .endingTwo:
                    await MusicManager.shared.playMusic(named: "bgm_ending")
                    coordinator.pop()
                    break
                }
            }
        }
    }
}
