//
//  MainGameView.swift
//  SpriteKitExample
//
//  Created by 한건희 on 7/9/25.
//

import SwiftUI
import SpriteKit

struct MainGameView: View {
    @StateObject var mainGameState = MainGameState()
    @StateObject var dialogManager = DialogManager()
    
    var scene: SKScene? {
        // MARK: GameScene.sks 파일로 scene 을 초기화하기 위해서는 fileNamed: 파라미터를 반드시 붙여주어야 함.
        let scene = MainGameScene(fileNamed: "MainGameScene")
        scene?.gameState = mainGameState
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
                mainGameState.isPaused.toggle()
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
            
            DialogView(dialogManager: dialogManager, isPresented: $mainGameState.isChatting)
                .opacity(mainGameState.isChatting ? 1 : 0)
                .offset(y: mainGameState.isChatting ? 0 : 100)
                .animation(.spring(duration: 0.5, bounce: 0.1), value: mainGameState.isChatting)
            
            PauseView(isPaused: $mainGameState.isPaused)
                .opacity(mainGameState.isPaused ? 1 : 0)
                .animation(.spring(duration: 0.5), value: mainGameState.isPaused)
        }
        .onAppear {
            dialogManager.initConversation(dialogPartner: .computer)
        }
    }
}



#Preview {
    MainGameView()
}
