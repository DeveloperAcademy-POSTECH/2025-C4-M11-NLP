//
//  SignalMachineDetailView.swift
//  NLP
//
//  Created by 양시준 on 7/24/25.
//

import SwiftUI

struct SignalMachineDetailView: View {
    var action: [SignalMachinePhase: () -> Void]
    @Binding var phase: SignalMachinePhase
    @State private var skipStreaming: Bool = false
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(.black.opacity(0.1))
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 24) {
                    if phase.playerText != nil {
                        StreamingText(fullDialog: phase.playerText!, streamingSpeed: 0.03, skip: $skipStreaming)
                            .font(NLPFont.body)
                            .foregroundStyle(.white)
                    }
                    StreamingText(fullDialog: phase.signalText, streamingSpeed: 0.03, skip: $skipStreaming)
                        .font(NLPFont.body)
                        .foregroundStyle(NLPColor.green)
                }
                Spacer()
                
                HStack {
                    Spacer()
                    Button(action: {
                        if let action = action[phase] {
                            action()
                        }
                        phase = phase.nextPhase ?? .lastPhase
                    }) {
                        Text("다음 >")
                            .font(NLPFont.body)
                            .foregroundStyle(.white)
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
