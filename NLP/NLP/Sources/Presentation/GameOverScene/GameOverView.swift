//
//  GameOverView.swift
//  NLP
//
//  Created by 양시준 on 7/31/25.
//

import SwiftUI

struct GameOverView: View {
    @State var isTransitioning: Bool = true
    @State var isGameOverShown: Bool = false
    
    @ObservedObject var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        ZStack {
            Image("StartGameImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            Text("Game Over")
                .font(NLPFont.headline)
                .foregroundStyle(NLPColor.label)
                .opacity(isGameOverShown ? 1 : 0)
                .animation(.linear(duration: 1), value: isGameOverShown)
        }
        .ignoresSafeArea()
        .background(.blue)
        .onAppear {
            isTransitioning = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isGameOverShown = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 9) {
                coordinator.popAllAndPush(.startGameScene)
            }
        }
    }
}
