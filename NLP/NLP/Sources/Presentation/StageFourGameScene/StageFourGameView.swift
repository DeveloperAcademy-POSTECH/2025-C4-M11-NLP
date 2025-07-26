//
//  StageFourGameView.swift
//  NLP
//
//  Created by Ted on 7/24/25.
//

import SwiftUI
import SpriteKit

struct StageFourGameView: View {
    @StateObject var viewModel: StageFourGameViewModel
    @State var scene: StageFourGameScene = StageFourGameScene(fileNamed: "StageFourGameScene")!
        
    init(coordinator: Coordinator) {
        _viewModel = StateObject(wrappedValue: StageFourGameViewModel(coordinator: coordinator))
    }
    
    var body: some View {
        ZStack {
            SpriteView(scene: scene)
                .ignoresSafeArea()
            if viewModel.state.isMonologuePresented {
                MonologueView(
                    actions: [
                        .pinnMonologueFour: [
                            MonologueAction(
                                monologue: "그래도 지구를 구해야 해.",
                                action: {
                                    viewModel.action(.saveEarthButtonTapped)
                                }
                            ),
                            MonologueAction(
                                monologue: "키리듐을 포기할 수는 없어.",
                                action: {
                                    viewModel.action(.dontGiveupKiridiumButtonTapped)
                                }
                            )
                        ],
                        .endingOnePartOne: [
                            MonologueAction(
                                monologue: "다음",
                                action: {
                                    viewModel.action(.goToEndingOneScene)
                                }
                            )
                        ],
                        .endingTwoPartFive: [ /// ...고마웠다 JTO. 너를 절대로 잊지 않을거야. 절대로.
                            MonologueAction(
                                monologue: "다음",
                                action: {
                                    viewModel.action(.robotExplodeStart)
                                    Task {
                                        await scene.moveRobotToPlasma()
                                        await scene.fleeAllExceptRobot()
                                        await scene.explode()
                                        viewModel.action(.goToEndingTwoScene)
                                        scene.setCameraFocusToAir()
                                    }
                                }
                            )
                        ],
                        .endingTwoPartSix: [
                            MonologueAction(
                                monologue: "다음",
                                action: {
                                    Task {
                                        viewModel.action(.goToNextPhase)
                                        await scene.robotComeBack()
                                    }
                                }
                            )
                        ],
                        .endingTwoPartEight: [
                            MonologueAction(
                                monologue: "다음",
                                action: {
                                    viewModel.action(.goToEndingCreditScene)
                                }
                            )
                        ]
                    ],
                    phase: $viewModel.state.phase,
                    skip: $viewModel.state.skip
                )
            }
            Color.black
                .ignoresSafeArea()
                .opacity(viewModel.state.isTransitioning ? 1 : 0)
        }
        .onAppear {
            initializeScene()
            viewModel.action(.viewAppeared)
        }
        .allowsHitTesting(!viewModel.state.blockViewTapAction)
    }
    
    private func initializeScene() {
        scene.scaleMode = .aspectFill
        scene.viewModel = viewModel
    }
}
