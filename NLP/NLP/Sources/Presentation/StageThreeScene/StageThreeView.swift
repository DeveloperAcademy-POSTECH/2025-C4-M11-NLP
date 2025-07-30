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
    
    @ObservedObject var scene: StageThreeGameScene
    
    init(coordinator: Coordinator, dialogManager: DialogManager) {
        _viewModel = StateObject(wrappedValue: StageThreeViewModel(coordinator: coordinator))
        self.dialogManager = dialogManager
        scene = NLPDIContainer.shared.resolve(StageThreeGameScene.self)!
    }
    
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
                            let dieHaptic = GradientHaptic()
                            dieHaptic.setCurve([
                                (0.0, 0.2),
                                (1.0, 0.5),
                                (2.0, 0.2)
                            ])
                            try? await Task.sleep(for: .seconds(1))
                            scene.changeRobotToDead()
                            scene.showKillerRobot()
                            dieHaptic.playHapticGradient(duration: 2.0)
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
            .airFinnTalk7: [
                MonologueAction(
                    monologue: "다음",
                    action: {
                        viewModel.action(.fadeOutAndIn(withNextPhase: true))
                        viewModel.action(.deactivateMonologue)
                        Task {
                            try? await Task.sleep(for: .seconds(1))
                            scene.changePositionPlayerToSignalMachine()
                        }
                    }
                )
            ],
            .receiveSign2: [
                MonologueAction(
                    monologue: "다음",
                    action: {
                        viewModel.action(.deactivateMonologue)
                        scene.changeRobotToNew()
                        scene.moveToSignalMachineFinn {
                            viewModel.action(.activateMonologue(withNextPhase: true))
                        }
                    }
                )
            ],
            .receiveSign7: [
                MonologueAction(
                    monologue: "다음",
                    action: {
                        viewModel.action(.deactivateMonologue)
                        scene.changePositionPlayerToSignalMachine()
                        viewModel.action(.goToNextPhase)
                    }
                )
            ],
            .receiveSign10: [
                MonologueAction(
                    monologue: "다음",
                    action: {
                        viewModel.action(.deactivateMonologue)
                        scene.moveToPlazmaRoomDoor {
                            viewModel.action(.activateMonologue(withNextPhase: true))
                        }
                        scene.moveFinnToPlazmaRoomDoor()
                    }
                )
            ],
            .lockedDoor1: [
                MonologueAction(
                    monologue: "다음",
                    action: {
                        viewModel.action(.deactivateMonologue)
                        scene.moveRobotToPlazmaRoomDoor {
                            viewModel.action(.activateMonologue(withNextPhase: true))
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
                        Task { await MusicManager.shared.playMusic(named: "bgm_6") }
                        viewModel.coordinator.push(.middleStoryScene(.stageThreeFour))
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
