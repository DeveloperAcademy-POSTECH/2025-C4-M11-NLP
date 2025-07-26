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
    @Binding var skip: Bool
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(.black.opacity(0.1))
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 24) {
                    StreamingText(coloredText: phase.dialogText, streamingSpeed: 0.03, skip: $skip)
                        .font(NLPFont.body)
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

#Preview {
    SignalMachineDetailView(
        action: [:],
        phase: .constant(SignalMachinePhase.signal3),
        skip: .constant(false))
}
