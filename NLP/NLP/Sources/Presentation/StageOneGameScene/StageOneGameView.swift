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
            
            
            
            if viewModel.state.isNoteFoundPresented {
                ItemCollectionView(
                    isPresented: $viewModel.state.isNoteFoundPresented,
                    item: GameItems.note,  // ⭐ 직접 참조
                    backButtonTapAction: {
                        viewModel.action(.hideNoteFoundPresented)
                    },
                    nextButtonTapAction: {
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
                        viewModel.action(.showDialog)
                    
                    }
                )
            }
            
            
            
            
            
            
            
//            // TODO: 손전등 발견 화면 구현
//            LightInfo()
//                .opacity(viewModel.state.isFlashlightFoundPresented ? 1 : 0)
//                .animation(.spring(duration: 0.5), value: viewModel.state.isFlashlightFoundPresented)
//                .onTapGesture {
//                    scene.hideFlashlight()
//                    viewModel.action(.hideFlashlightFoundPresented)
//                    scene.changeLightMode(lightMode: .turnOnFlashlight)
//                    viewModel.state.stageOnePhase = .findFlashlight
//                    viewModel.action(.showDialog)
//                }
//            
//            NoteInfoView()
//                .opacity(viewModel.state.isNoteFoundPresented ? 1 : 0)
//                .animation(.spring(duration: 0.5), value: viewModel.state.isNoteFoundPresented)
//                .onTapGesture {
//                    scene.hideNote()
//                    viewModel.action(.hideNoteFoundPresented)
//                    viewModel.state.stageOnePhase = .findNote
//                    viewModel.action(.showDialog)
//                }
            
        }
        .onAppear {
            
            initializeScene()
            
            
            scene.changeLightMode(lightMode: .noLight)
            dialogManager.initConversation(dialogPartner: .computer)
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
                        // TODO: 비밀번호 입력 창
                        viewModel.state.stageOnePhase = .lockedDoor.nextPhase!
                        viewModel.action(.showDialog)
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
//
//
//
//#Preview {
//    @Previewable @StateObject var dialogManager = DialogManager()
//    let coordinator = Coordinator()
//    coordinator.push(.stageOneScene)
//    return StageOneGameView(coordinator: coordinator, dialogManager: dialogManager)
//}
