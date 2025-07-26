//
//  MiddleStoryView.swift
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
            
            Spacer().frame(height: 80)
            
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
                .foregroundStyle(.white)
                .padding(.bottom, 30)
                .padding(.horizontal, 24)
            Text(stories[viewModel.state.storyIndex].storyDescription)
                .font(NLPFont.body)
                .foregroundStyle(.white)
                .padding(.horizontal, 24)
            Spacer()
            
            HStack {
                Button(isClickSoundAvailable: true, action: {
                    viewModel.action(.goToPreviousStory)
                }) {
                    Image(viewModel.state.isPreviousAvailable ? "previous-available" : "previous-unavailable")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 50)
                }
                .disabled(!viewModel.state.isPreviousAvailable)
                
                Spacer()
                Button(isClickSoundAvailable: true, action: {
                    viewModel.action(.goToNextStory)
                }) {
                    Image(viewModel.state.isNextAvailable ? "next-available" : "next-unavailable")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 50)
                }
                .disabled(!viewModel.state.isNextAvailable)
            }
            .padding(.bottom, 40)
            .padding(.horizontal, 24)
        }
        .ignoresSafeArea()
        .background(Color(NLPColor.gray1))
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
    case endingOne
    case endingTwo
    
    var stories: [GameStory] {
        switch self {
        case .stageOneTwo:
            return ConstantMiddleStories.stageOneTwo
        case .stageTwoThree:
            return ConstantMiddleStories.stageTwoThree
        case .endingOne:
            return ConstantMiddleStories.endingOne
        case .endingTwo:
            return ConstantMiddleStories.endingTwo
        }
    }
}

#Preview {
    @Previewable @StateObject var coordinator = Coordinator()
    MiddleStoryView(coordinator: coordinator, storiesType: .stageOneTwo)
}
