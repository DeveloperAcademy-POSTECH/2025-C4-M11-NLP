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
    
    init() {
        UINavigationBar.setAnimationsEnabled(false)
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.paths) {
            // MARK: 바로 아래 StartGameView는 앱 실행 시 처음 보이는 뷰로, 개발 Feature에 따라서 해당 부분 다른 뷰로 변경하여 테스트 하시면 됩니다!
            StartGameView(coordinator: coordinator)
//            StageLoadingView(stageAllLoaded: $stageAllLoaded)
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
                        StageOneGameView(coordinator: coordinator, dialogManager: dialogManager)
                            .toolbar(.hidden, for: .navigationBar)
                    case .stageTwoScene:
                        StageTwoView(coordinator: coordinator, dialogManager: dialogManager)
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
                var elapsed: Double = 0
                let startTime = Date()
                let stageOneGameScene = await StageOneGameScene(fileNamed: "StageOneGameScene")!.preInitialize()
                NLPDIContainer.shared.register(type: StageOneGameScene.self, dependency: stageOneGameScene)
                loadedStageCount += 1
                let stageOneEndTime = Date()
                elapsed = stageOneEndTime.timeIntervalSince(startTime)
                print("stageOneEndTime", elapsed)
                
                let stageTwoGameScene = await StageTwoGameScene(fileNamed: "StageTwoGameScene")!.preInitialize()
                NLPDIContainer.shared.register(type: StageTwoGameScene.self, dependency: stageTwoGameScene)
                loadedStageCount += 1
                let stageTwoEndTime = Date()
                elapsed = stageTwoEndTime.timeIntervalSince(stageOneEndTime)
                print("stageTwoEndTime",elapsed)
                
                let stageThreeGameScene = await StageThreeGameScene(fileNamed: "StageThreeGameScene")!.preInitialize()
                NLPDIContainer.shared.register(type: StageThreeGameScene.self, dependency: stageThreeGameScene)
                loadedStageCount += 1
                let stageThreeEndTime = Date()
                elapsed = stageThreeEndTime.timeIntervalSince(stageTwoEndTime)
                print("stageThreeEndTime",elapsed)
                
                let stageFourGameScene = await StageFourGameScene(fileNamed: "StageFourGameScene")!.preInitialize()
                NLPDIContainer.shared.register(type: StageFourGameScene.self, dependency: stageFourGameScene)
                loadedStageCount += 1
                let stageFourEndTime = Date()
                elapsed = stageFourEndTime.timeIntervalSince(stageThreeEndTime)
                print("stageFourEndTime",elapsed)
                
                stageAllLoaded = true
            }
        }
    }
}

struct StageLoadingView: View {
    
    @Binding var stageAllLoaded: Bool
    @State var progressRate: CGFloat = 0
    @State var timer: Timer?
    
    init(stageAllLoaded: Binding<Bool>) {
        self._stageAllLoaded = stageAllLoaded
    }
    
    var body: some View {
        Color.black
            .ignoresSafeArea()
            .overlay(
                VStack {
                    Spacer()
                    Text("스테이지 로딩중 ... \n잠시 기다려주세요")
                        .multilineTextAlignment(.center)
                        .lineSpacing(10)
                        .foregroundStyle(.white)
                        .font(NLPFont.headline)
                        .padding(.bottom, 30)
                    RoundedRectangle(cornerRadius: 999)
                        .fill(NLPColor.gray1)
                        .frame(
                            width: ConstantScreenSize.screenWidth - 100,
                            height: 5
                        )
                        .overlay(
                            GeometryReader { proxy in
                                HStack {
                                    RoundedRectangle(cornerRadius: 999)
                                        .fill(.white)
                                        .frame(width: proxy.size.width * progressRate, height: proxy.size.height)
                                        .animation(.linear, value: progressRate)
                                    Spacer()
                                }
                            }
                        )
                        .padding(.bottom, 40)
                    Text("✅ 스테이지 로딩 완료!")
                        .font(NLPFont.headline)
                        .opacity(stageAllLoaded ? 1 : 0)
                    Spacer()
                }
            )
            .onAppear {
                timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [self] timer in
                    withAnimation {
                        self.progressRate += 0.01
                    }
                    if progressRate >= 1 {
                        timer.invalidate()
                    }
                }
            }
    }
}

#Preview {
    @Previewable @State var stageAllLoaded: Bool = false
    StageLoadingView(stageAllLoaded: $stageAllLoaded)
}
