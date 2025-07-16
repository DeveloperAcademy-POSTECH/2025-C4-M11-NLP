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
                    phase: $viewModel.state.stageOnePhase,
                    isPresented: $viewModel.state.isDialogPresented,
                    firstButtonAction: {
                        switch viewModel.state.stageOnePhase {
                        default:
                            break
                        }
                    },
                    secondButtonAction: {
                        switch viewModel.state.stageOnePhase {
                        case .stageArrived:
                            viewModel.action(.hideDialog)
                        case .goToCenteralControlRoom:
                            viewModel.action(.hideDialog)
                            scene.moveToCenteralControlRoom() {
                                viewModel.state.stageOnePhase = .lockedDoor
                                viewModel.action(.showDialog)
                            }
                        case .lockedDoor:
                            viewModel.action(.hideDialog)
                            // TODO: 비밀번호 입력 창 오픈
                        case .startFinding:
                            viewModel.action(.hideDialog)
                        default:
                            break
                        }
                    }
                )
            }
            
            DialogView(dialogManager: dialogManager, isPresented: $viewModel.state.isChatting)
                .opacity(viewModel.state.isChatting ? 1 : 0)
                .offset(y: viewModel.state.isChatting ? 0 : 100)
                .animation(.spring(duration: 0.5, bounce: 0.1), value: viewModel.state.isChatting)
            
            // TODO: 손전등 발견 화면 구현
            Rectangle()
                .frame(width: 200, height: 200)
                .background(Color.blue)
                .opacity(viewModel.state.isFlashlightFoundPresented ? 1 : 0)
                .animation(.spring(duration: 0.5), value: viewModel.state.isFlashlightFoundPresented)
                .onTapGesture {
                    scene.hideFlashlight()
                    viewModel.action(.hideFlashlightFoundPresented)
                    scene.changeLightMode(lightMode: .turnOnFlashlight)
                    viewModel.state.stageOnePhase = .findFlashlight
                    viewModel.action(.showDialog)
                }
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
}



#Preview {
    @Previewable @StateObject var dialogManager = DialogManager()
    let coordinator = Coordinator()
    coordinator.push(.stageOneScene)
    return StageOneGameView(coordinator: coordinator, dialogManager: dialogManager)
}
