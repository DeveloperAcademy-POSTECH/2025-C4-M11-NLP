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
            
            DialogView(
                dialogManager: dialogManager,
                isPresented: $viewModel.state.isDialogPresented
            )
            .opacity(viewModel.state.isDialogPresented ? 1 : 0)
            .onChange(of: dialogManager.conversationLogs[.robot] ?? []) { oldValue, newValue in
                // MARK: 대화가 처음 6번 이상 넘어갈 경우 호출
                if viewModel.state.stageTwoPhase == .tryEmotionalApproach || viewModel.state.stageTwoPhase == .meetBot {
                    if (newValue.count == 5 || newValue.count == 10) {
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
            dialogManager.initConversation(
                dialogPartner: .robot,
                instructions: ConstantInstructions.jtoAskFeeling,
                tools: []
            )
            
            dialogManager.addLogs(dialogPartner: .robot, dialog: "안녕하세요? 오랜만이군요. 기분은 좀 어떠신가요?", sender: .partner)
            
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
                         viewModel.action(.activateDialog(withNextPhase: false))
                    }
                ),
            ],
            .tryEmotionalApproach: [
                MonologueAction(
                    monologue: "대화하기",
                    action: {
                        dialogManager.resetDialogLog()
                        viewModel.action(.activateDialog(withNextPhase: false))
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
                        dialogManager.initConversation(
                            dialogPartner: .robot,
                            instructions: ConstantInstructions.jtoJoke, // 내일 sad 로 바꾸자...
                            tools: [RecognizeJokeTool(afterRecognizeAction: {
                                dialogManager.toolCalled = true
                                dialogManager.initConversation(
                                    dialogPartner: .robot,
                                    instructions: ConstantInstructions.jtoHappy,
                                    tools: [RecognizeHappyTool(afterRecognizeAction: {
                                        dialogManager.toolCalled = true
                                        Task {
                                            dialogManager.addLogs(dialogPartner: .robot, dialog: "그 말을 들으니 너무 기뻐요!", sender: .partner, fromToolCalling: false)
                                            try? await Task.sleep(nanoseconds: 1_000_000_000)
                                            dialogManager.addLogs(dialogPartner: .robot, dialog: "문제해결 모드로 전환되었습니다.", sender: .partner, fromToolCalling: true)
                                            try? await Task.sleep(nanoseconds: 1_000_000_000)
                                            dialogManager.addLogs(dialogPartner: .robot, dialog: "통신 복구를 시작합니다.", sender: .partner, fromToolCalling: true)
                                            try? await Task.sleep(nanoseconds: 1_000_000_000)
                                            dialogManager.addLogs(dialogPartner: .robot, dialog: "통신이 복구되었습니다.", sender: .partner, fromToolCalling: true)
                                        }
                                        // TODO: 페이지 넘어가기.
                                    })]
                                )
                                dialogManager.addLogs(
                                    dialogPartner: .robot,
                                    dialog: "너무 재밌어요!! 이제 정말 기쁜 말을 해주시면 돼요.",
                                    sender: .partner,
                                    fromToolCalling: true
                                )
                            })]
                        )
                        
                        dialogManager.addLogs(dialogPartner: .robot, dialog: "저는 지금 공감모드로 고정돼있어요. 모드 전환을 위해서는 감정을 표현해주셔야 해요. 제인이 그렇게 정했어요.\n\n먼저, 장난스러운 말을 해주세요.", sender: .partner)
                        viewModel.action(.activateDialog(withNextPhase: false))
                    }
                )
            ]
        ]
    }
}

//dialogManager.initConversation(
//    dialogPartner: .robot,
//    instructions: ConstantInstructions.jtoHappy, // 내일 sad 로 바꾸자...
//    tools: [RecognizeHappyTool(afterRecognizeAction: {
//        dialogManager.toolCalled = true
//        dialogManager.addLogs(
//            dialogPartner: .robot,
//            dialog: "잘하셨어요! 저도 행복해요 :)",
//            sender: .partner,
//            fromToolCalling: true
//        )
//    })]
//)



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
