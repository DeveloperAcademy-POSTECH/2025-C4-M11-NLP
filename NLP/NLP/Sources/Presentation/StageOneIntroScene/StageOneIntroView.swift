//
//  StageOneIntroView.swift
//  NLP
//
//  Created by Ted on 7/14/25.
//

import SwiftUI

struct StageOneIntroView: View {
    @StateObject var viewModel: StageOneIntroViewModel
    
    init(coordinator: Coordinator) {
        _viewModel = StateObject(wrappedValue: StageOneIntroViewModel(coordinator: coordinator))
    }
    
    var body: some View {
        switch viewModel.state.phase {
        case .heartBeat:
            HeartBeatView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                        viewModel.state.phase = .introDialog
                    }
                }
        case .introDialog:
            IntroDialogView(dialogsEndAction: {
                viewModel.state.phase = .introDialogEnd
            })
        case .introDialogEnd:
            IntroDialogEndView(startButtonTapped: {
                // MARK: 시작하기 버튼 탭 시 첫 게임 Stage 로 이동합니다.
                 viewModel.action(.startButtonTapped)
            })
        }
    }
}




#Preview {
    @Previewable @State var lineNumber: Int = 1
    @Previewable @State var dialogs: [String] = [
        "…우우우우우웅…",
        "귀 안쪽에서 울리는 무언의 진동음. 정적 위에 얹힌 소음은 마치 몸속 심장 박동처럼 느껴졌다.",
        "눈을 떴다.",
        "오래된 배선들과 부서진 격벽, 그리고 어둠 속에서 깜빡이는 단 하나의 붉은 불빛.",
        "나는 바닥에 누워 있다. 아니지, 공중을 부유하고 있다.",
        "숨을 쉬자 폐 안쪽이 타들어가는 듯한 고통이 밀려왔다.",
        "산소가 부족하다."]
    StreamingText(fullDialog: dialogs[lineNumber - 1], streamingSpeed: 0.05) {
        guard lineNumber < dialogs.count else {
            // MARK: 다음 화면 전환
            return
        }
        lineNumber += 1
    }
}
