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
    @State private var skipStreaming: Bool = false
    
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
                    phase: $viewModel.state.stageThreePhase,
                    skip: $skipStreaming
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
            
            if viewModel.state.isSignalMachinePresented {
                SignalMachineDetailView(
                    action: configureSignalMachineActions(),
                    phase: $viewModel.state.signalMachinePhase,
                    skip: $skipStreaming
                )
            }
        }
        .onAppear {
            initScene()
            viewModel.action(.transitionComplete)
            viewModel.state.isMonologuePresented = true
        }
        .task {
            scene.hideKillerRobot()
            scene.hideFlame()
        }
        .onChange(of: viewModel.state.isSignalMachinePresented) { _, newValue in
            if newValue {
                scene.signalMachineInteractionStart()
            } else {
                scene.signalMachineInteractionEnd()
            }
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
                        Task {
                            try? await Task.sleep(for: .seconds(1))
                            scene.changeRobotToDead()
                            scene.showKillerRobot()
                        }
                    }
                )
            ],
            .jtoDie3: [
                MonologueAction(
                    monologue: "다음",
                    action: {
                        viewModel.action(.activateItemCollecting)
                        scene.standUpFinn()
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
                        viewModel.state.isMonologuePresented = false
                        viewModel.action(.goToNextPhase)
                        scene.moveToSignalMachine()
                    }
                )
            ],
            .receiveSign3: [
                MonologueAction(
                    monologue: "다음",
                    action: {
                        viewModel.action(.deactivateMonologue)
                        scene.changeRobotToNew()
                        scene.moveToSignalMachineRobot()
                        scene.moveToSignalMachineFinn {
                            viewModel.action(.activateMonologue(withNextPhase: true))
                        }
                    }
                )
            ],
            .receiveSign8: [
                MonologueAction(
                    monologue: "다음",
                    action: {
                        viewModel.state.isMonologuePresented = false
                        scene.moveToSignalMachine()
                        viewModel.action(.goToNextPhase)
                    }
                )
            ],
            .receiveSign11: [
                MonologueAction(
                    monologue: "다음",
                    action: {
                        viewModel.action(.fadeOutAndIn(withNextPhase: true))
                        Task {
                            try? await Task.sleep(for: .seconds(1))
                            scene.changePositionPlayerToPlazmaRoomDoor()
                            scene.changePositionFinnToPlazmaRoomDoor()
                            scene.changePositionRobotToPlazmaRoomDoor()
                        }
                    }
                )
            ],
            .lockedDoor5: [
                MonologueAction(
                    monologue: "다음",
                    action: {
                        viewModel.action(.goToNextPhase)
                        Task {
                            scene.moveRobotToAnalyzeDoor()
                            scene.movePlayerToAnalyzeDoor()
                            scene.moveFinnToAnalyzeDoor()
                        }
                    }
                )
            ],
            .lockedDoor7: [
                MonologueAction(
                    monologue: "다음",
                    action: {
                        viewModel.action(.deactivateMonologue)
                        Task {
                            try? await Task.sleep(for: .seconds(1))
                            scene.showFlame()
                            scene.explodeAnimation()
                        }
                        Task {
                            try? await Task.sleep(for: .seconds(4))
                            scene.hideFlame()
                            scene.hideDoor()
                            scene.moveRobotToAfterExplosion()
                            viewModel.action(.activateMonologue(withNextPhase: true))
                        }
                    }
                )
            ],
            .explosion2: [
                MonologueAction(
                    monologue: "다음",
                    action: {
                        scene.moveAfterExplosionJanePosition()
                        viewModel.action(.goToNextPhase)
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
    
    private func configureSignalMachineActions() -> [SignalMachinePhase: () -> Void] {
        return [
            .signal4: {
                viewModel.action(.deactivateSignalMachine)
                viewModel.action(.activateMonologue(withNextPhase: true))
            },
            .signalAgain: {
                viewModel.action(.deactivateSignalMachine)
                viewModel.action(.activateMonologue(withNextPhase: false))
            }
        ]
    }
}
