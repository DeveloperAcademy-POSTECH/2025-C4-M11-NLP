//
//  StageOneGameView.swift
//  NLP
//
//  Created by 양시준 on 7/14/25.
//

import SwiftUI
import SpriteKit


struct StageOneGameView: View {
    @StateObject var viewModel: StageOneGameViewModel
    @ObservedObject var dialogManager = DialogManager()
    @State private var skipStreaming: Bool = false
    
    init(coordinator: Coordinator, dialogManager: DialogManager) {
        self._viewModel = StateObject(wrappedValue: StageOneGameViewModel(coordinator: coordinator))
        self.dialogManager = dialogManager
    }
    
    @State var scene: StageOneGameScene = StageOneGameScene(fileNamed: "StageOneGameScene")!
    @State private var isDoorOpened: Bool = false
    @State private var isOxygenDecreasingStarted: Bool = false
    @State private var explorationTimer: Timer? = nil

    var body: some View {
        ZStack(alignment: .bottom) {
            SpriteView(scene: scene)
                .ignoresSafeArea()
            
            if viewModel.state.isDialogPresented {
                MonologueView(
                    actions: configureMonologueActions(),
                    phase: $viewModel.state.stageOnePhase,
                    skip: $skipStreaming
                )
            }
            
            DialogView(
                dialogManager: dialogManager,
                isPresented: $viewModel.state.isChatting
            )
                .opacity(viewModel.state.isChatting ? 1 : 0)
                .offset(y: viewModel.state.isChatting ? 0 : 100)
                .animation(.spring(duration: 0.5, bounce: 0.1), value: viewModel.state.isChatting)
            
            if viewModel.state.isChatBotChatting {
                DialogChatView(
                    dialogManager: dialogManager,
                    isPresented: $viewModel.state.isChatBotChatting
                )
                .background(Color.black.opacity(0.8))
                .zIndex(100)
            }
            
            DialogView(
                dialogManager: dialogManager,
                isPresented: $viewModel.state.isOxygenChatting
            )
                .opacity(viewModel.state.isOxygenChatting ? 1 : 0)
                .offset(y: viewModel.state.isOxygenChatting ? 0 : 100)
                .animation(.spring(duration: 0.5, bounce: 0.1), value: viewModel.state.isOxygenChatting)
            
            if viewModel.state.isPasswordViewPresented {
                PasswordView(
                    backButtonTapAction: {
                        viewModel.action(.hidePasswordView)
                        // 산소 부족 경고가 이미 표시되었다면 대화를 다시 표시하지 않음
                        if !viewModel.state.isOxygenWarningShown {
                            viewModel.state.stageOnePhase = .decreaseOxygen
                            viewModel.action(.showDialog)
                            viewModel.action(.oxygenWarningShown)
                        }
                    },
                    successAction: {
                        viewModel.action(.hidePasswordView)
                        viewModel.coordinator.push(.middleStoryScene(.stageOneTwo))
                    },
                    failureAction: {
                        viewModel.action(.hidePasswordView)
                        if !viewModel.state.isPasswordWarningShown {
                            viewModel.state.stageOnePhase = .wrongPassword
                            viewModel.action(.showDialog)
                            viewModel.state.isPasswordWarningShown = true
                        }
                    },
                    isDoorOpened: $isDoorOpened
                )
            }
            
            if viewModel.state.isNoteFoundPresented {
                ItemCollectionView(
                    isPresented: $viewModel.state.isNoteFoundPresented,
                    item: GameItems.note,  // ⭐ 직접 참조
                    backButtonTapAction: {
                        viewModel.action(.hideNoteFoundPresented)
                    },
                    nextButtonTapAction: {
                        viewModel.action(.hideNoteFoundPresented)
                        viewModel.action(.showDialog)
                    }
                )
            }
            
            if viewModel.state.isFlashlightFoundPresented {
                ItemCollectionView(
                    isPresented: $viewModel.state.isFlashlightFoundPresented,
                    item: GameItems.flashLight,  // ⭐ 직접 참조
                    backButtonTapAction: {
                        viewModel.action(.hideFlashlightFoundPresented)
                    },
                    nextButtonTapAction: {
                        scene.hideFlashlight()
                        viewModel.action(.hideFlashlightFoundPresented)
                        viewModel.action(.flashlightFound)
                        scene.changeLightMode(lightMode: .turnOnFlashlight)
                        viewModel.state.stageOnePhase = .findFlashlight
                        viewModel.action(.showDialog)
                    },
                    showXButton: false
                )
            }
            
            if viewModel.state.isOxygenDecreasingStarted && !isDoorOpened {
                VStack {
                    OxygenGaugeView(initialOxygen: 30) {
                        withAnimation(.linear(duration: 1)) {
                            viewModel.state.isTransitioning = true
                        }
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.top, 16)
            }

            if viewModel.state.isChatBotSettingPresented {
                ChatBotInstructionInputView(
                    isPresented: $viewModel.state.isChatBotSettingPresented,
                    instruction: $viewModel.state.chatBotInstruction
                )
            }
        }
        .overlay(
            Color.black
                .opacity(viewModel.state.isTransitioning ? 1 : 0)
                .animation(.linear(duration: 1), value: viewModel.state.isTransitioning)
                .ignoresSafeArea()
        )
        .onChange(of: viewModel.state.isTransitioning) { newValue in
            if newValue == true {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    viewModel.state.isTransitioning = false
                }
            }
            if newValue == false {
                // 1. paths를 비운다
                viewModel.coordinator.paths = []
                // 2. 아주 짧은 딜레이 후 다시 push
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    viewModel.coordinator.paths = [.stageOneScene]
                }
            }
        }
        .onChange(of: viewModel.state.stageOnePhase) { newPhase in
            if newPhase == .decreaseOxygen && !viewModel.state.isOxygenResolved {
                viewModel.state.isOxygenDecreasingStarted = true
            }
        }
        .onChange(of: viewModel.state.isExplorationStarted) { isStarted in
            if isStarted && !viewModel.state.isFlashlightFound {
                // 돌아다니기 시작하고 손전등을 아직 발견하지 않았다면 10초 타이머 시작
                startExplorationTimer()
            }
        }
        .onChange(of: viewModel.state.isFlashlightFound) { isFound in
            if isFound {
                // 손전등을 발견하면 탐색 타이머 취소
                explorationTimer?.invalidate()
                explorationTimer = nil
            }
        }
        .onChange(of: viewModel.state.isOxygenFound) { isFound in
            if isFound {
                // 산소 발견 시 게이지만 해결 (아이템은 유지)
                viewModel.state.isOxygenDecreasingStarted = false
                viewModel.state.isOxygenResolved = true
            }
        }
        .onChange(of: viewModel.state.isOxygenDecreasingStarted) { isStarted in
            if isStarted {
                MusicManager.shared.playMusic(named: "bgm_oxygen")
            } else {
                MusicManager.shared.playMusic(named: "bgm_3")
            }
        }
        .onChange(of: viewModel.state.isChatBotChatting) { isChatBotChatting in
            if isChatBotChatting {
                dialogManager.currentPartner = .chatBot
                dialogManager.initConversation(
                    dialogPartner: .chatBot,
                    instructions: viewModel.state.chatBotInstruction.isEmpty ? DialogPartnerType.chatBot.instructions : viewModel.state.chatBotInstruction,
                    tools: []
                )
            }
        }
        .onChange(of: viewModel.state.isOxygenChatting) { isOxygenChatting in
            if isOxygenChatting {
                dialogManager.initConversation(
                    dialogPartner: .oxygen,
                    instructions: DialogPartnerType.oxygen.instructions,
                    tools: [
                        OxygenTool()
                    ]
                )
            }
        }
        .onChange(of: viewModel.state.isChatting) { isChatting in
            if isChatting {
                dialogManager.initConversation(
                    dialogPartner: .computer,
                    instructions: DialogPartnerType.computer.instructions,
                    tools: [
                        UnlockTool(rightPasswordAction: {
                            dialogManager.initializeSession(
                                dialogPartner: .computer,
                                instructions: ConstantInstructions.computerOnboarding,
                                tools: []
                            )
                        })
                    ]
                )
            }
        }
        .onAppear {
            initializeScene()
            MusicManager.shared.playMusic(named: "bgm_3")
            dialogManager.initConversation(
                dialogPartner: .computer,
                instructions: DialogPartnerType.computer.instructions,
                tools: [
                    UnlockTool(rightPasswordAction: {
                        dialogManager.initializeSession(
                            dialogPartner: .computer,
                            instructions: ConstantInstructions.computerOnboarding,
                            tools: []
                        )
                    })
                ]
            )
        }
        .onDisappear {
            // 타이머 정리
            explorationTimer?.invalidate()
            explorationTimer = nil
        }
    }
    
    private func initializeScene() {
        scene.viewModel = viewModel
        scene.scaleMode = .aspectFill
    }
    
    private func startExplorationTimer() {
        // 기존 타이머가 있다면 취소
        explorationTimer?.invalidate()
        
        // 10초 후 산소 부족 트리거
        explorationTimer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { _ in
            if !viewModel.state.isFlashlightFound {
                // 손전등을 아직 발견하지 않았다면 산소 부족 트리거
                viewModel.state.stageOnePhase = .decreaseOxygen
                viewModel.action(.showDialog)
                viewModel.action(.oxygenWarningShown)
            }
        }
    }
  
    private func configureMonologueActions() -> [StageOneMonologuePhase: [MonologueAction]] {
        return [
            .stageArrived: [
                MonologueAction(
                    monologue: "돌아다니기",
                    action: {
                        viewModel.action(.hideDialog)
                        viewModel.action(.startExploration)
                    }
                )
            ],
            .goToCenteralControlRoom: [
                MonologueAction(
                    monologue: "이동하기",
                    action: {
                        viewModel.action(.hideDialog)
                        scene.moveToCenteralControlRoom {
                            viewModel.action(.showDialog)
                            viewModel.state.stageOnePhase = .goToCenteralControlRoom.nextPhase!
                        }
                    }
                )
            ],
            .lockedDoor: [
                MonologueAction(
                    monologue: "비밀번호 입력하기",
                    action: {
                        viewModel.action(.hideDialog)
                        viewModel.action(.showPasswordView)
//                        viewModel.state.stageOnePhase = .lockedDoor.nextPhase!
//                        viewModel.action(.showDialog)
                    }
                )
            ],
            .startFinding: [
                MonologueAction(
                    monologue: "주위 둘러보기",
                    action: {
                        viewModel.action(.hideDialog)
                    }
                )
            ]
        ]
    }
}
