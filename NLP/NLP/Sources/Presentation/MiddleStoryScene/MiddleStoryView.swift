//
//  StageOneTwoMiddleStoryView.swift
//  NLP
//
//  Created by Ted on 7/18/25.
//

import SwiftUI

struct MiddleStoryView: View {
    @StateObject var viewModel: MiddleStoryViewModel
    
    init(
        coordinator: Coordinator,
        storiesType: StoriesType
    ) {
        _viewModel = StateObject(wrappedValue: MiddleStoryViewModel(
            coordinator: coordinator,
            storiesType: storiesType
        ))
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
            }
            let stories = viewModel.state.storiesType.stories
            
            Spacer().frame(height: 60)
            
            if let image = stories[viewModel.state.storyIndex].storyImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 270, height: 208)
            } else {
                Rectangle()
                    .fill(.white)
                    .frame(width: 270, height: 208)
            }
            Spacer().frame(height: 20)
            Text(stories[viewModel.state.storyIndex].storyTitle)
                .font(NLPFont.headline)
                .padding(.bottom, 30)
                .padding(.horizontal, 24)
            Text(stories[viewModel.state.storyIndex].storyDescription)
                .font(NLPFont.body)
                .padding(.horizontal, 24)
            Spacer()
            GameButton(buttonText: "다음") {
                viewModel.action(.goToNextStory)
            }
            .padding(.bottom, 40)
            .padding(.horizontal, 24)
        }
        .ignoresSafeArea()
        .background(Color.gray)
        .overlay(
            Color.black
                .opacity(viewModel.state.isTransitioning ? 1 : 0)
        )
    }
}

/// 각 스테이지 넘어가는 위치에 따라 스토리 끝나고 실행시킬 게임 스테이지가 달라지므로, MiddleStoryView에 StoriesType을 넘기도록 구현
enum StoriesType {
    case stageOneTwo
    case stageTwoThree
    
    var stories: [GameStory] {
        switch self {
        case .stageOneTwo:
            return ConstantMiddleStories.stageOneTwo
        case .stageTwoThree:
            return ConstantMiddleStories.stageTwoThree
        }
    }
}
