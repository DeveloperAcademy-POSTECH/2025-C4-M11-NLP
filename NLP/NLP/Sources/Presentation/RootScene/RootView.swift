//
//  RootView.swift
//  NLP
//
//  Created by Ted on 7/14/25.
//

import SwiftUI

struct RootView: View {
    @StateObject var coordinator: Coordinator = Coordinator()
    @StateObject var dialogManager: DialogManager = DialogManager()
    
    init() {
        UINavigationBar.setAnimationsEnabled(false)
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.paths) {
            // MARK: 바로 아래 StartGameView는 앱 실행 시 처음 보이는 뷰로, 개발 Feature에 따라서 해당 부분 다른 뷰로 변경하여 테스트 하시면 됩니다!
            StartGameView(coordinator: coordinator)
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
    }
}
