//
//  IntroDialogEndView.swift
//  NLP
//
//  Created by Ted on 7/14/25.
//
import SwiftUI

struct IntroDialogEndView: View {
    @State var isStartButtonEnabled: Bool = false
    var startButtonTapped: (() -> Void)?
    @State private var skipStreaming: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            HStack {
                Spacer()
            }
            StreamingText(
                fullDialog: ConstantGameDialogs.introDialogBeforeStageOneStart,
                streamingSpeed: 0.1,
                skip: $skipStreaming
            ) {
                isStartButtonEnabled = true
            }
            .multilineTextAlignment(.leading)
            .lineSpacing(35)
            .foregroundStyle(.white)
            Spacer()
            
            HStack {
                Spacer()
                GameButton(
                    buttonText: "시작하기",
                    buttonWidth: 154
                ) {
                    guard let startButtonTapped = startButtonTapped else { return }
                    startButtonTapped()
                }
                .padding(.bottom, 70)
                Spacer()
            }
            .opacity(isStartButtonEnabled ? 1 : 0)
            .disabled(!isStartButtonEnabled)
            .animation(
                .linear,
                value: isStartButtonEnabled
            )
        }
        .padding(.horizontal, 24)
        .ignoresSafeArea()
        .background(.black)
    }
}
