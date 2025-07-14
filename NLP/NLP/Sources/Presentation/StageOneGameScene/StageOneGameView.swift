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
    @StateObject var dialogManager = DialogManager()
    
    init(coordinator: Coordinator) {
        self._viewModel = StateObject(wrappedValue: StageOneGameViewModel(coordinator: coordinator))
    }
    
    var scene: SKScene? {
        // MARK: GameScene.sks 파일로 scene 을 초기화하기 위해서는 fileNamed: 파라미터를 반드시 붙여주어야 함.
        let scene = StageOneGameScene(fileNamed: "StageOneGameScene")
        scene?.viewModel = viewModel
        scene?.scaleMode = .aspectFill
        return scene
    }
    
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
            
            PauseView(isPaused: $viewModel.state.isPaused)
                .opacity(viewModel.state.isPaused ? 1 : 0)
                .animation(.spring(duration: 0.5), value: viewModel.state.isPaused)
        }
        .onAppear {
            dialogManager.initConversation(dialogPartner: .computer)
        }
    }
}



#Preview {
    var coordinator = Coordinator()
    coordinator.push(.stageOneScene)
    return StageOneGameView(coordinator: coordinator)
}
