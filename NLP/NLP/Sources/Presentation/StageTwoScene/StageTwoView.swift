//
//  StageTwoView.swift
//  NLP
//
//  Created by Ted on 7/15/25.
//

import SpriteKit
import SwiftUI


struct StageTwoView: View {
    @StateObject var viewModel: StageTwoViewModel
    
    init(coordinator: Coordinator) {
        _viewModel = StateObject(wrappedValue: StageTwoViewModel(coordinator: coordinator))
    }
    
    var scene: SKScene {
        let scene = StageTwoScene(fileNamed: "StageTwoScene")!
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
                    phase: $viewModel.state.stageTwoPhase,
                    isPresented: $viewModel.state.isDialogPresented
                ) {
                    viewModel.state.isDialogPresented = false
                    print("hi")
                }
            }
        }
    }
}



