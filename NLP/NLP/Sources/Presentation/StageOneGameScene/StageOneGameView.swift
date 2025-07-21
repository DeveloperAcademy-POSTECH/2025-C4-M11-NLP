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
    
    init(coordinator: Coordinator, dialogManager: DialogManager) {
        self._viewModel = StateObject(wrappedValue: StageOneGameViewModel(coordinator: coordinator))
        self.dialogManager = dialogManager
    }
    
    @State var scene: StageOneGameScene = StageOneGameScene(fileNamed: "StageOneGameScene")!

    var body: some View {
        ZStack(alignment: .bottom) {
            SpriteView(scene: scene)
                .ignoresSafeArea()
            
            if viewModel.state.isDialogPresented {
                MonologueView(
                    actions: configureMonologueActions(),
                    phase: $viewModel.state.stageOnePhase
                )
            }
            
            DialogView(
                dialogManager: dialogManager,
                isPresented: $viewModel.state.isChatting
            )
                .opacity(viewModel.state.isChatting ? 1 : 0)
                .offset(y: viewModel.state.isChatting ? 0 : 100)
                .animation(.spring(duration: 0.5, bounce: 0.1), value: viewModel.state.isChatting)
            
            if viewModel.state.isPasswordViewPresented {
                PasswordView(
                    backButtonTapAction: {
                        viewModel.action(.hidePasswordView)
                    },
                    successAction: {
                        viewModel.action(.hidePasswordView)
                        viewModel.coordinator.push(.middleStoryScene(.stageOneTwo))
                    },
                    failureAction: {
                        viewModel.action(.hidePasswordView)
                        viewModel.state.stageOnePhase = .wrongPassword
                        viewModel.action(.showDialog)
                    }
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
                        scene.changeLightMode(lightMode: .turnOnFlashlight)
                        viewModel.state.stageOnePhase = .findFlashlight
                        viewModel.action(.showDialog)
                    }
                )
            }
        }
        .onAppear {
            initializeScene()
            dialogManager.initConversation(
                dialogPartner: .computer,
                instructions: DialogPartnerType.computer.instructions,
                tools: [
                    UnlockTool(rightPasswordAction: {
                        // MARK: computer instruction 변경(암호를 맞춘 후, 컴퓨터가 어떠한 응답을 내뱉어줄지에 대한 instruction으로) 및 세션 초기화
                        dialogManager.initializeSession(
                            dialogPartner: .computer,
                            instructions: ConstantInstructions.computerOnboarding,
                            tools: [] // TODO: 미결정
                        )
                    })
                ]
            )
        }
    }
    
    private func initializeScene() {
        scene.viewModel = viewModel
        scene.scaleMode = .aspectFill
    }
  
    private func configureMonologueActions() -> [StageOneMonologuePhase: [MonologueAction]] {
        return [
            .stageArrived: [
                MonologueAction(
                    monologue: "돌아다니기",
                    action: {
                        viewModel.action(.hideDialog)
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
