//
//  MonologueView.swift
//  NLP
//
//  Created by Ted on 7/15/25.
//
import SwiftUI

struct MonologueView<T: MonologuePhase>: View {
    @Binding var phase: T
    @Binding var isPresented: Bool
    
    var firstButtonAction: (() -> Void)
    var secondButtonAction: (() -> Void)
    
    var body: some View {
        VStack {
            StreamingText(fullDialog: phase.monologue, streamingSpeed: 0.06)
                .font(NLPFont.chapterDescription)
                .foregroundStyle(.white)
            
            Spacer()
            
            if phase.buttonTexts.count == 2 {
                HStack(spacing: 10) {
                    GameButton(buttonText: phase.buttonTexts[0]) {
                        // 첫번째 버튼 액션을 따로 호출할 필요가 있다면
                        if phase.isFirstButtonActionEnabled {
                            firstButtonAction()
                            return
                        }
                        
                        // 그렇지 않다면 이전 페이즈로 가는데, 이전 페이즈 없으면 모달 내려버리고
                        guard let previousPhase = phase.previousPhase else {
                            isPresented = false
                            return
                        }
                        
                        // 페이즈 있으면 이전 페이지로 정상 이동
                        phase = previousPhase
                    }
                    GameButton(buttonText: phase.buttonTexts[1]) {
                        if phase.isSecondButtonActionEnabled {
                            secondButtonAction()
                            return
                        }
                        phase = phase.nextPhase!
                    }
                }
            } else {
                GameButton(buttonText: phase.buttonTexts[0]) {
                    if phase.isSecondButtonActionEnabled {
                        secondButtonAction()
                        return
                    }
                    phase = phase.nextPhase ?? T.lastPhase
                }
            }
        }
        .padding(.all, 10)
        .background(
            Rectangle()
                .fill(.black.opacity(0.4))
                .stroke(Color.yellow, lineWidth: 6)
        )
        .frame(width: ConstantScreenSize.screenWidth - 40, height: 280)
    }
}
