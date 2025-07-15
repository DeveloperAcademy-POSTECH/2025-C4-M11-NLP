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
    
    @State private var scene: StageOneGameScene?
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if let scene = scene {
                SpriteView(scene: scene)
                    .ignoresSafeArea()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            }
            
            Button(action: {
                viewModel.state.isPaused.toggle()
            }) {
                Image(systemName: "pause.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.white)
                    .frame(width: 40)
                    .padding(.leading, 24)
                    .padding(.top, 45)
            }
            .buttonStyle(.plain)
            
            DialogView(dialogManager: dialogManager, isPresented: $viewModel.state.isChatting)
                .opacity(viewModel.state.isChatting ? 1 : 0)
                .offset(y: viewModel.state.isChatting ? 0 : 100)
                .animation(.spring(duration: 0.5, bounce: 0.1), value: viewModel.state.isChatting)
            
            // TODO: 대화창으로 변경
            Rectangle()
                .frame(width: 200, height: 200)
                .background(Color.blue)
                .opacity(viewModel.state.isFoundFlashlight ? 1 : 0)
                .animation(.spring(duration: 0.5), value: viewModel.state.isFoundFlashlight)
                .onTapGesture {
                    viewModel.state.isFoundFlashlight = false
                    viewModel.state.hasFlashlight = true
                    viewModel.state.isFlashlightOn = true
                }
            
            PauseView(isPaused: $viewModel.state.isPaused)
                .opacity(viewModel.state.isPaused ? 1 : 0)
                .animation(.spring(duration: 0.5), value: viewModel.state.isPaused)
        }
        .onAppear {
            if scene == nil {
                // 기존의 생성 로직을 그대로 가져옵니다.
                let scene = StageOneGameScene(fileNamed: "StageOneGameScene")
                scene?.viewModel = viewModel
                scene?.scaleMode = .aspectFill
                self.scene = scene // @State 변수에 생성된 Scene을 할당합니다.
            }
            
            dialogManager.initConversation(dialogPartner: .computer)
        }
    }
}



#Preview {
    @Previewable @StateObject var dialogManager = DialogManager()
    let coordinator = Coordinator()
    coordinator.push(.stageOneScene)
    return StageOneGameView(coordinator: coordinator, dialogManager: dialogManager)
}
