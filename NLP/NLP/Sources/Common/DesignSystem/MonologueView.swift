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
    var nextButtonAction: (() -> Void)
    
    var body: some View {
        VStack {
            StreamingText(fullDialog: phase.monologue, streamingSpeed: 0.06)
                .font(NLPFont.chapterDescription)
                .foregroundStyle(.white)
            
            Spacer()
            
            if phase.buttonTexts.count == 2 {
                HStack(spacing: 10) {
                    GameButton(buttonText: phase.buttonTexts[0]) {
                        guard let previousPhase = phase.previousPhase else {
                            isPresented = false
                            return
                        }
                        phase = previousPhase
                    }
                    GameButton(buttonText: phase.buttonTexts[1]) {
                        if phase.isNextButtonActionEnabled {
                            nextButtonAction()
                            return
                        }
                        phase = phase.nextPhase!
                    }
                }
            } else {
                GameButton(buttonText: phase.buttonTexts[0]) {
                    if phase.isNextButtonActionEnabled {
                        nextButtonAction()
                        return
                    }
                    phase = phase.nextPhase!
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
