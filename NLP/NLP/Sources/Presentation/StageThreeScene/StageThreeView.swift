//
//  StageThreeView.swift
//  NLP
//
//  Created by 양시준 on 7/22/25.
//

import SpriteKit
import SwiftUI

struct StageThreeView: View {
    @StateObject var viewModel: StageThreeViewModel
    @ObservedObject var dialogManager: DialogManager
    
    init(coordinator: Coordinator, dialogManager: DialogManager) {
        _viewModel = StateObject(wrappedValue: StageThreeViewModel(coordinator: coordinator))
        self.dialogManager = dialogManager
    }
    
    @State var scene: StageThreeGameScene = StageThreeGameScene(fileNamed: "StageTwoGameScene")!
    
    var body: some View {
        ZStack(alignment: .bottom) {
            SpriteView(scene: scene)
                .ignoresSafeArea()
            
            if viewModel.state.isMonologuePresented {
                MonologueView(
                    actions: configureMonologueActions(),
                    phase: $viewModel.state.stageThreePhase
                )
            }
        }
        .onAppear {
            initScene()
            viewModel.action(.transitionComplete)
            viewModel.state.isMonologuePresented = true
        }
        .overlay(
            Color.black
                .opacity(viewModel.state.isTransitioning ? 1 : 0)
        )
    }
    
    private func initScene() {
        scene.viewModel = viewModel
        scene.scaleMode = .aspectFill
    }
    
    private func configureMonologueActions() -> [StageThreeMonologuePhase: [MonologueAction]] {
        return [
            .findFinn2: [
                MonologueAction(
                    monologue: "다음",
                    action: {
                        viewModel.action(.fadeOutAndIn(withNextPhase: true))
                    }
                )
            ]
        ]
    }
}
