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
    
    @State var scene: StageTwoGameScene = StageTwoGameScene(fileNamed: "StageTwoGameScene")!
    
    var body: some View {
        ZStack(alignment: .bottom) {
            SpriteView(scene: scene)
                .ignoresSafeArea()
            
            if viewModel.state.isMonologuePresented {
                MonologueView(
                    actions: configureMonologueActions(),
                    phase: $viewModel.state.stageTwoPhase
                )
            }
            
            if viewModel.state.isItemCollecting {
                ItemCollectionView(
                    isPresented: $viewModel.state.isItemCollecting,
                    item: GameItems.pdaOfJain,
                    backButtonTapAction: {
                        viewModel.action(.activateMonologue(withNextPhase: true))
                    },
                    nextButtonTapAction: {
                        viewModel.action(.activateMonologue(withNextPhase: true))
                    }
                )
            }
            
            if viewModel.state.isDialogPresented {
                DialogView(
                    dialogManager: dialogManager,
                    isPresented: $viewModel.state.isDialogPresented
                )
                .onChange(of: dialogManager.conversationLogs[dialogManager.currentPartner!] ?? []) { oldValue, newValue in
                    // MARK: 대화가 처음 6번 이상 넘어갈 경우 호출
                    if dialogManager.currentPartner == .robot
                        && (newValue.count == 5 || newValue.count == 10) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            viewModel.action(.activateMonologue(withNextPhase: true))
                        }
                    }
                }
            }
        }
        .overlay(
            Color.black
                .opacity(viewModel.state.isTransitioning ? 1 : 0)
        )
        .allowsHitTesting(!viewModel.state.isTouchDisabled)
        .onAppear {
            initScene()
            dialogManager.initConversation(dialogPartner: .robot)
            
            viewModel.action(.transitionComplete)
        }
    }
    
    private func initScene() {
        scene.viewModel = viewModel
        scene.scaleMode = .aspectFill
    }
    
    private func configureMonologueActions() -> [StageTwoMonologuePhase: [MonologueAction]] {
        return [
            .meetBot: [
                MonologueAction(
                    monologue: "대화하기",
                    action: {
                        // viewModel.action(.changeDialogPartner(.bot)) // TODO: 액션 추가
                         viewModel.action(.activateDialog(withNextPhase: true))
                    }
                ),
            ],
            .tryEmotionalApproach: [
                MonologueAction(
                    monologue: "대화하기",
                    action: {
                        viewModel.action(.activateDialog(withNextPhase: true))
                    }
                )
            ],
            .giveOrTalkChoice: [
                MonologueAction(
                    monologue: "손전등 주기",
                    action: {
                        viewModel.action(.goToNextPhase)
                    }
                ),
                MonologueAction(
                    monologue: "대화하기",
                    action: {
                        viewModel.action(.activateDialog(withNextPhase: false))
                    }
                )
            ],
            .unexpectedBotReaction: [
                MonologueAction(
                    monologue: "다음",
                    action: {
                        Task {
                            viewModel.action(.deactivateMonologue)
                            viewModel.action(.disableTouch)
                            await scene.robotBringPda()
                            viewModel.action(.activateMonologue(withNextPhase: true))
                            viewModel.action(.activateTouch)
                        }
                    }
                )
            ],
            .unexpectedAffectionMoment: [
                MonologueAction(
                    monologue: "확인하기",
                    action: {
                        Task {
                            await scene.setPdaTransparent()
                            await scene.setRobotHappy()
                            viewModel.action(.activateItemCollecting)
                        }
                    }
                )
            ],
            .botBehaviorShiftNoticed: [
                MonologueAction(
                    monologue: "다음",
                    action: {
                        
                    }
                )
            ]
        ]
    }
}



//isPresented: $viewModel.state.isMonologuePresented,
//firstButtonAction: {
//    switch viewModel.state.stageTwoPhase {
//    case .giveOrTalkChoice:
//        print("손전등 주기 완료.") // TODO: StageTwoScene에서 로봇에게 손전등 주는 로직 구현 필요
//        viewModel.action(.goToNextPhase)
//        
//    default:
//        break
//    }
//},
//secondButtonAction: {
//    switch viewModel.state.stageTwoPhase {
//    case .meetBot:
//        viewModel.action(.activateDialog)
//        viewModel.action(.goToNextPhase)
//    case .giveOrTalkChoice:
//        viewModel.action(.activateDialog)
//    case .tryEmotionalApproach:
//        viewModel.action(.activateDialog)
//        viewModel.action(.goToNextPhase)
//    case .unexpectedAffectionMoment:
//        viewModel.action(.activateItemCollecting)
//        viewModel.action(.goToNextPhase)
//    default:
//        viewModel.action(.goToNextPhase)
//        break
//    }
//}
