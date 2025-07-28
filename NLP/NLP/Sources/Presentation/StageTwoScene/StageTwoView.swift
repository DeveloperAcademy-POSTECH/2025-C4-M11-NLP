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
    @State private var skipStreaming: Bool = false
    
    @ObservedObject var scene: StageTwoGameScene
    
    init(coordinator: Coordinator, dialogManager: DialogManager) {
        _viewModel = StateObject(wrappedValue: StageTwoViewModel(coordinator: coordinator))
        self.dialogManager = dialogManager
        scene = NLPDIContainer.shared.resolve(StageTwoGameScene.self)!
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            SpriteView(scene: scene)
                .ignoresSafeArea()
            
            if viewModel.state.isMonologuePresented {
                MonologueView(
                    actions: configureMonologueActions(),
                    phase: $viewModel.state.stageTwoPhase,
                    skip: $skipStreaming
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
            
            DialogChatView(
                dialogManager: dialogManager,
                isPresented: $viewModel.state.isDialogPresented,
                onSend: {
                    print("onsend work")
                    print("viewModel.state.stageTwoPhase is \(viewModel.state.stageTwoPhase)")
//                    if viewModel.state.stageTwoPhase == .tryEmotionalApproach {
//                        viewModel.state.talkChatCount += 1
//                    }
                    // "Finn" 대답 처리
                    if let lastMessage = dialogManager.conversationLogs[.robot]?.last,
                       lastMessage.content.lowercased().contains("finn") {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            viewModel.action(.goToMiddleStory)
                        }
                    }
                },
                initialMessage: "안녕하세요! 저는 로봇입니다. 무엇을 도와드릴까요?"
            )
            .opacity(viewModel.state.isDialogPresented ? 1 : 0)
            .onChange(of: dialogManager.conversationLogs[.robot] ?? []) { oldValue, newValue in
                // MARK: 대화가 처음 6번 이상 넘어갈 경우 호출
                if dialogManager.currentPartner == .robot && (newValue.count == 5 || newValue.count == 10) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        viewModel.state.isDialogPresented = false
                        viewModel.state.isMonologuePresented = true

                        if viewModel.state.stageTwoPhase == .meetBot {
                            viewModel.action(.goToNextPhase)
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
            dialogManager.initConversation(
                dialogPartner: .robot,
                instructions: "",
                tools: []
            )
            viewModel.action(.transitionComplete)
            viewModel.action(.activateMonologue(withNextPhase: false))
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
                         viewModel.action(.activateDialog(withNextPhase: false))
                    }
                ),
            ],
            .tryEmotionalApproach: [
                MonologueAction(
                    monologue: "손전등 주기",
                    action: {
                         viewModel.action(.goToNextPhase)
                    }
                ),
                MonologueAction(
                    monologue: "대화하기",
                    action: {
                        print("MonologueAction 호출")
                        dialogManager.resetDialogLog()
                        viewModel.action(.activateMonologue(withNextPhase: false))
                        viewModel.action(.activateDialog(withNextPhase: false))
                    }
                )
            ],
            
            
//            .tryEmotionalApproach: {
//                var actions: [MonologueAction] = [
//                    MonologueAction(
//                        monologue: "!손전등 주기",
//                        action: {
//                            viewModel.action(.goToNextPhase)
//                        }
//                    )
//                ]
//                print("viewModel.state.talkChatCount is \(viewModel.state.talkChatCount)")
//                if viewModel.state.talkChatCount < 30 {
//                    actions.append(
//                        MonologueAction(
//                            monologue: "!대화하기",
//                            action: {
//                                dialogManager.resetDialogLog()
//                                viewModel.action(.activateDialog(withNextPhase: false))
//                            }
//                        )
//                    )
//                }
//                return actions
//            }(),
//            .giveOrTalkChoice: [
//                MonologueAction(
//                    monologue: "손전등 주기",
//                    action: {
//                        viewModel.action(.goToNextPhase)
//                    }
//                ),
//                MonologueAction(
//                    monologue: "대화하기",
//                    action: {
//                        viewModel.action(.activateDialog(withNextPhase: false))
//                    }
//                )
//            ],
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
                        viewModel.action(.goToNextPhase)
                    }
                )
            ],
            .jtoProblemModeInactive: [
                MonologueAction(
                    monologue: "다음",
                    action: {
                        viewModel.action(.goToNextPhase)
                    }
                )
            ],
            .jtoProblemModeSad: [
                MonologueAction(
                    monologue: "다음",
                    action: {
                        viewModel.action(.goToNextPhase)
                    }
                )
            ],
            .journeyContinues: [
                MonologueAction(
                    monologue: "다음",
                    action: {
                        viewModel.action(.deactivateMonologue)
                    }
                )
            ],
            .stageArrived: [
                MonologueAction(
                    monologue: "다음",
                    action: {
                        viewModel.action(.deactivateMonologue)
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
