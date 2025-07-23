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
    
    @State var scene: StageThreeGameScene = StageThreeGameScene(fileNamed: "StageThreeGameScene")!
    
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
            
            if viewModel.state.isItemCollecting {
                ItemCollectionView(
                    isPresented: $viewModel.state.isItemCollecting,
                    item: GameItems.killerRobot,
                    backButtonTapAction: {
                        viewModel.action(.activateMonologue(withNextPhase: true))
                    },
                    nextButtonTapAction: {
                        viewModel.action(.activateMonologue(withNextPhase: true))
                        viewModel.state.isItemCollecting = false
                    }
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
            .stageArrived: [
                MonologueAction(
                    monologue: "다음",
                    action: {
                        viewModel.action(.deactivateMonologue)
                        scene.moveToFinn {
                            viewModel.action(.activateMonologue(withNextPhase: true))
                        }
                    }
                )
            ],
            .findFinn2: [
                MonologueAction(
                    monologue: "다음",
                    action: {
                        viewModel.action(.fadeOutAndIn(withNextPhase: true))
                    }
                )
            ],
            .jtoDie3: [
                MonologueAction(
                    monologue: "다음",
                    action: {
                        viewModel.action(.activateItemCollecting)
                    }
                )
            ],
            .airFinnTalk4: [
                MonologueAction(
                    monologue: "이해해.. 정말 무서웠을거야.",
                    action: {
                        viewModel.action(.goToPhase(to: .airFinnTalk5_1))
                    }
                ),
                MonologueAction(
                    monologue: "기억이 없어도 책임은 남아.",
                    action: {
                        viewModel.action(.goToPhase(to: .airFinnTalk5_2))
                    }
                ),
            ],
            .airFinnTalk6: [
                MonologueAction(
                    monologue: "다음",
                    action: {
                        viewModel.action(.fadeOutAndIn(withNextPhase: true))
                    }
                )
            ],
            .receiveSign11: [
                MonologueAction(
                    monologue: "다음",
                    action: {
                        viewModel.action(.fadeOutAndIn(withNextPhase: true))
                    }
                )
            ],
            .lockedDoor8: [
                MonologueAction(
                    monologue: "다음",
                    action: {
                        viewModel.action(.fadeOutAndIn(withNextPhase: true))
                    }
                )
            ],
            .explosion6: [
                MonologueAction(
                    monologue: "다음",
                    action: {
                        
                    }
                )
            ]
        ]
    }
}
