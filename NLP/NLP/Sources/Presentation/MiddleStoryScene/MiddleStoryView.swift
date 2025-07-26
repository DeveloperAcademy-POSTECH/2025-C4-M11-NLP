//
//  MiddleStoryView.swift
//  NLP
//
//  Created by Ted on 7/18/25.
//

import SwiftUI

struct MiddleStoryView: View {
    @StateObject var viewModel: MiddleStoryViewModel
    @State private var isStreamingCompleted: Bool = false
    @State private var skipStreaming: Bool = false
    
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
        ZStack {
            Color(red: 36/255, green: 36/255, blue: 36/255).ignoresSafeArea()
            VStack {
                HStack { Spacer() }
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
                if let storyTitle = stories[viewModel.state.storyIndex].storyTitle {
                    Text(storyTitle)
                        .font(NLPFont.headline)
                        .foregroundColor(.white)
                        .padding(.bottom, 30)
                        .padding(.horizontal, 24)
                }
                StreamingText(
                    fullDialog: stories[viewModel.state.storyIndex].storyDescription,
                    streamingSpeed: 0.03,
                    skip: $skipStreaming,
                    streamingCompleted: { isStreamingCompleted = true }
                )
                .font(NLPFont.body)
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 24)
                .onAppear {
                    isStreamingCompleted = false
                    skipStreaming = false
                }
                Spacer()
                HStack {
                    Button(isClickSoundAvailable: true, action: {
                        if !skipStreaming {
                            skipStreaming.toggle()
                            return
                        }
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
                        if !skipStreaming {
                            skipStreaming.toggle()
                            return
                        }
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
        }
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
    case stageThreeFour
    
    var stories: [GameStory] {
        switch self {
        case .stageOneTwo:
            return ConstantMiddleStories.stageOneTwo
        case .stageTwoThree:
            return ConstantMiddleStories.stageTwoThree
        case .stageThreeFour:
            return ConstantMiddleStories.stageThreeFour
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
