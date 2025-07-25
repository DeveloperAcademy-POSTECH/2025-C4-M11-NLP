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
    }
    
    enum Action {
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
        case .goToNextStory:
            // 뒤에 스토리가 더 있다면
            if state.storyIndex < state.storiesType.stories.count - 1 {
                state.storyIndex += 1
                return
            }
            
            Task {
                await MainActor.run {
                    withAnimation(.linear(duration: 1)) {
                        state.isTransitioning = true
                    }
                }
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                
                // 스토리의 마지막이라면
                switch state.storiesType {
                case .stageOneTwo:
                    coordinator.push(.stageTwoScene)
                case .stageTwoThree:
                    // 임의
                    coordinator.push(.stageTwoScene)
                }
            }
        }
    }
}
