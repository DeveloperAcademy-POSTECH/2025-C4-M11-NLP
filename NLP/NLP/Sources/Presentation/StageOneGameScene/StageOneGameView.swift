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
    
    var scene: SKScene {
        let scene = StageOneGameScene(fileNamed: "StageOneGameScene")!
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
                    actions: configureMonologueActions(),
                    phase: $viewModel.state.stageOnePhase,
                )
            }
            
            DialogView(
                dialogManager: dialogManager,
                isPresented: $viewModel.state.isChatting
            )
                .opacity(viewModel.state.isChatting ? 1 : 0)
                .offset(y: viewModel.state.isChatting ? 0 : 100)
                .animation(.spring(duration: 0.5, bounce: 0.1), value: viewModel.state.isChatting)
            
            // TODO: 손전등 발견 화면 구현
            Rectangle()
                .frame(width: 200, height: 200)
                .background(Color.blue)
                .opacity(viewModel.state.isFoundFlashlight ? 1 : 0)
                .animation(.spring(duration: 0.5), value: viewModel.state.isFoundFlashlight)
                .onTapGesture {
                    viewModel.state.isFoundFlashlight = false
                    viewModel.state.hasFlashlight = true
                    viewModel.state.isFlashlightOn = true
                    viewModel.state.stageOnePhase = .findFlashlight
                    viewModel.action(.toggleDialogPresentation)
                }
        }
        .onAppear {
            dialogManager.initConversation(dialogPartner: .computer)
        }
    }
    
    private func configureMonologueActions() -> [StageOneMonologuePhase: [MonologueAction]] {
        return [
            .stageArrived: [
                MonologueAction(
                    monologue: "돌아다니기",
                    action: {
                        viewModel.action(.toggleDialogPresentation)
                    }
                )
            ],
            .goToCenteralControlRoom: [
                MonologueAction(
                    monologue: "이동하기",
                    action: {
                        viewModel.action(.toggleDialogPresentation)
                        viewModel.state.isMovingToCentralControlRoom = true
                        viewModel.state.isMovingToCentralControlRoom = false
                        viewModel.action(.toggleDialogPresentation)
                        viewModel.state.stageOnePhase = .goToCenteralControlRoom.nextPhase!
                    }
                )
            ],
            .lockedDoor: [
                MonologueAction(
                    monologue: "비밀번호 입력하기",
                    action: {
                        viewModel.action(.toggleDialogPresentation)
                        // TODO: 비밀번호 입력 창
                        viewModel.action(.toggleDialogPresentation)
                        viewModel.state.stageOnePhase = .lockedDoor.nextPhase!
                    }
                )
            ],
            .startFinding: [
                MonologueAction(
                    monologue: "주위 둘러보기",
                    action: {
                        viewModel.action(.toggleDialogPresentation)
                    }
                )
            ]
        ]
    }
}



#Preview {
    @Previewable @StateObject var dialogManager = DialogManager()
    let coordinator = Coordinator()
    coordinator.push(.stageOneScene)
    return StageOneGameView(coordinator: coordinator, dialogManager: dialogManager)
}
