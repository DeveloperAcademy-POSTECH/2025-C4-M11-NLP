//
//  RootView.swift
//  NLP
//
//  Created by Ted on 7/14/25.
//

import SwiftUI
import SpriteKit

struct RootView: View {
    @StateObject var coordinator: Coordinator = Coordinator()
    @StateObject var dialogManager: DialogManager = DialogManager()
    @State var loadedStageCount: Int = 0
    @State var stageAllLoaded: Bool = false
    
    @State var isPresented: Bool = true
    init() {
        UINavigationBar.setAnimationsEnabled(false)
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.paths) {
            // MARK: 바로 아래 StartGameView는 앱 실행 시 처음 보이는 뷰로, 개발 Feature에 따라서 해당 부분 다른 뷰로 변경하여 테스트 하시면 됩니다!
            // DialogChatView(dialogManager: dialogManager, isPresented: $isPresented)
            ZStack {
                StartGameView(coordinator: coordinator)
                GameLoadingView(stageAllLoaded: $stageAllLoaded)
                    .opacity(!stageAllLoaded ? 1 : 0)
            }
                .animation(.linear(duration: 1), value: stageAllLoaded)
                .toolbar(.hidden, for: .navigationBar)
                .navigationDestination(for: CoordinatorPath.self) { path in
                    switch path {
                    case .startGameScene:
                        StartGameView(coordinator: coordinator)
                            .toolbar(.hidden, for: .navigationBar)
                    case .gameIntroScene:
                        GameIntroView(coordinator: coordinator)
                            .toolbar(.hidden, for: .navigationBar)
                    case .stageOneIntroScene:
                        StageOneIntroView(coordinator: coordinator)
                            .toolbar(.hidden, for: .navigationBar)
                    case .stageOneScene:
                        StageOneGameView(
                            coordinator: coordinator,
                            dialogManager: dialogManager
                        )
                            .toolbar(.hidden, for: .navigationBar)
                    case .stageTwoScene:
                        StageTwoView(
                            coordinator: coordinator,
                            dialogManager: dialogManager
                        )
                            .toolbar(.hidden, for: .navigationBar)
                    case .middleStoryScene(let storiesType):
                        MiddleStoryView(
                            coordinator: coordinator,
                            storiesType: storiesType
                        )
                        .toolbar(.hidden, for: .navigationBar)
                    case .stageThreeScene:
                        StageThreeView(
                            coordinator: coordinator,
                            dialogManager: dialogManager
                        )
                            .toolbar(.hidden, for: .navigationBar)
                        
                    case .endingCreditScene:
                        EndingCreditView(coordinator: coordinator)
                            .toolbar(.hidden, for: .navigationBar)
                    case .stageFourScene:
                        StageFourGameView(coordinator: coordinator)
                            .toolbar(.hidden, for: .navigationBar)
                    }
                }
        }
        .onAppear {
            Task {
                let stageOneGameScene = await StageOneGameScene(fileNamed: "StageOneGameScene")!.preInitialize()
                NLPDIContainer.shared.register(type: StageOneGameScene.self, dependency: stageOneGameScene)
                loadedStageCount += 1
                
                let stageTwoGameScene = await StageTwoGameScene(fileNamed: "StageTwoGameScene")!.preInitialize()
                NLPDIContainer.shared.register(type: StageTwoGameScene.self, dependency: stageTwoGameScene)
                loadedStageCount += 1
                
                let stageThreeGameScene = await StageThreeGameScene(fileNamed: "StageThreeGameScene")!.preInitialize()
                NLPDIContainer.shared.register(type: StageThreeGameScene.self, dependency: stageThreeGameScene)
                loadedStageCount += 1
                
                let stageFourGameScene = await StageFourGameScene(fileNamed: "StageFourGameScene")!.preInitialize()
                NLPDIContainer.shared.register(type: StageFourGameScene.self, dependency: stageFourGameScene)
                loadedStageCount += 1
                
                stageAllLoaded = true
            }
        }
    }
}


#Preview {
    @Previewable @State var stageAllLoaded: Bool = false
    GameLoadingView(stageAllLoaded: $stageAllLoaded)
}
