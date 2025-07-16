//
//  MonologueView.swift
//  NLP
//
//  Created by Ted on 7/15/25.
//
import SwiftUI

struct MonologueView<T: MonologuePhase>: View {
    let actions: [T: [MonologueAction]]
    @Binding var phase: T
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(.black.opacity(0.1))
            VStack {
                HStack {
                    StreamingText(fullDialog: phase.monologue, streamingSpeed: 0.03)
                        .font(NLPFont.chapterDescription)
                        .foregroundStyle(.white)
                    Spacer()
                }
                
                Spacer()
                
                if actions[phase] == nil {
                    HStack {
                        Spacer()
                        Button(action: {
                            phase = phase.nextPhase ?? .lastPhase
                        }) {
                            Text("다음 >")
                                .font(NLPFont.chapterTitle)
                                .foregroundStyle(.white)
                        }
                    }
                }
                else {
                    HStack {
                        VStack(spacing: 5) {
                            ForEach(actions[phase] ?? [], id: \.self) { action in
                                GameButton(buttonText: action.monologue) {
                                    action.action()
                                }
                            }
                        }
                        Spacer()
                    }
                }
                Spacer().frame(height: 35)
            }
            .padding(.all, 15)
            .background(
                Rectangle()
                    .fill(.gray.opacity(0.5))
            )
            .frame(width: ConstantScreenSize.screenWidth, height: 280)
        }
        .ignoresSafeArea()
    }
}
