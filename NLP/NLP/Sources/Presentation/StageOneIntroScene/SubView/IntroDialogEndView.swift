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
    @State private var isFadingOut: Bool = false
    
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
                    MusicManager.shared.stopMusic()
                    isFadingOut = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        guard let startButtonTapped = startButtonTapped else { return }
                        startButtonTapped()
                    }
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
        .overlay(
            Color.black
                .opacity(isFadingOut ? 1 : 0)
                .animation(.linear(duration: 1), value: isFadingOut)
                .ignoresSafeArea()
        )
        .onAppear {
            print("[IntroDialogEndView] onAppear - beat.mp3 재생 시도")
            MusicManager.shared.playMusic(named: "beat")
        }
    }
}
