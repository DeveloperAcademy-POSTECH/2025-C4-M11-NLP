//
//  StageTwoView.swift
//  NLP
//
//  Created by Ted on 7/15/25.
//

import SpriteKit
import SwiftUI


struct StageTwoView: View {
    @StateObject var viewModel: StageTwoViewModel
    
    init(coordinator: Coordinator) {
        _viewModel = StateObject(wrappedValue: StageTwoViewModel(coordinator: coordinator))
    }
    
    var scene: SKScene {
        let scene = StageTwoScene(fileNamed: "StageTwoScene")!
        scene.viewModel = viewModel
        scene.scaleMode = .aspectFill
        return scene
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            SpriteView(scene: scene)
                .ignoresSafeArea()
            
            if viewModel.state.isDialogPresented {
                MonologueView(
                    phase: $viewModel.state.stageTwoPhase,
                    isPresented: $viewModel.state.isDialogPresented,
                    firstButtonAction: {
                        switch viewModel.state.stageTwoPhase {
                        case .giveOrTalkChoice:
                            print("손전등 주기 완료.") // TODO: StageTwoScene에서 로봇에게 손전등 주는 로직 구현 필요
                            viewModel.state.stageTwoPhase = viewModel.state.stageTwoPhase.nextPhase!
                            
                        default:
                            break
                        }
                    },
                    secondButtonAction: {
                        switch viewModel.state.stageTwoPhase {
                        case .meetBot:
                            print("로봇과 대화 시작") // TODO: 로봇과 대화를 위해 DialogView로 이동 구현 필요
                            // 대화 완료했다 치고,
                            viewModel.state.stageTwoPhase = viewModel.state.stageTwoPhase.nextPhase!
                        case .giveOrTalkChoice:
                            print("다시 대화로 돌아가기") // TODO: 로봇과 대화를 위해 DialogView로 이동 구현 필요
                            viewModel.state.stageTwoPhase = viewModel.state.stageTwoPhase.nextPhase! // 임의
                        default:
                            break
                        }
                    }
                )
            }
        }
    }
}



