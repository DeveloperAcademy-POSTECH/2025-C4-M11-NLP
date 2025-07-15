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
    @ObservedObject var dialogManager: DialogManager
    
    init(coordinator: Coordinator, dialogManager: DialogManager) {
        _viewModel = StateObject(wrappedValue: StageTwoViewModel(coordinator: coordinator))
        self.dialogManager = dialogManager
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
            
            if viewModel.state.isMonologuePresented {
                MonologueView(
                    phase: $viewModel.state.stageTwoPhase,
                    isPresented: $viewModel.state.isMonologuePresented,
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
                            viewModel.state.stageTwoPhase = viewModel.state.stageTwoPhase.nextPhase!
                        case .tryEmotionalApproach:
                            viewModel.state.stageTwoPhase = viewModel.state.stageTwoPhase.nextPhase!
                            viewModel.state.isMonologuePresented = false
                            viewModel.state.isDialogPresented = true
                        case .unexpectedAffectionMoment:
                            viewModel.state.stageTwoPhase = viewModel.state.stageTwoPhase.nextPhase!
                            viewModel.state.isMonologuePresented = false
                            viewModel.state.isItemCollecting = true
                        default:
                            viewModel.state.stageTwoPhase = viewModel.state.stageTwoPhase.nextPhase!
                            break
                        }
                    }
                )
            }
            
            if viewModel.state.isItemCollecting {
                ItemCollectionView(
                    isPresented: $viewModel.state.isItemCollecting,
                    item: GameItems.pdaOfJain,
                    backButtonTapAction: {
                        viewModel.state.isItemCollecting = false
                        viewModel.state.isMonologuePresented = true
                    },
                    nextButtonTapAction: {
                        viewModel.state.isItemCollecting = false
                        viewModel.state.isMonologuePresented = true
                    }
                )
            }
            
            if viewModel.state.isDialogPresented {
                DialogView(
                    dialogManager: dialogManager,
                    isPresented: $viewModel.state.isDialogPresented
                )
            }
        }
    }
}



