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
    @Binding var skip: Bool
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(.black.opacity(0.1))
            
                VStack(alignment: .leading) {
                    StreamingText(coloredText: phase.monologue, streamingSpeed: 0.03, skip: $skip)
                        .font(NLPFont.body)
                        .foregroundStyle(phase.isSystemMonologue ? NLPColor.primary : NLPColor.label)
                    Spacer()
                    
                    HStack {
                        Spacer()
                        if actions[phase] == nil {
                            Button(isClickSoundAvailable: true, action: {
                                if !skip {
                                    skip.toggle()
                                    return
                                }
                                guard let nextPhase = phase.nextPhase else { return }
                                phase = nextPhase
                            }) {
                                Text("다음 >")
                                    .font(NLPFont.body)
                                    .foregroundStyle(NLPColor.gameOption)
                            }
                        }
                        // 조건 분기: 선택지 없을 때
                        else{
                            // 조건 분기: 선택지 있을 때
                            VStack(alignment: .trailing,spacing: 26){
                                // 선택지 버튼 반복
                                ForEach(actions[phase] ?? [], id: \.self) { action in
                                    GameButton(buttonText: action.monologue) {
                                        if !skip {
                                            skip.toggle()
                                            return
                                        }
                                        action.action()
                                    }
                                }
                                
                            }
                        }
                    }
                }
                .padding(.bottom,45)

            .padding(.all, 15)
            .background(
                Rectangle()
                    .fill(.gray.opacity(0.5))
            )
            .frame(width: ConstantScreenSize.screenWidth, height: ConstantScreenSize.screenHeight*0.35)
        }
        .ignoresSafeArea()
    }
}

