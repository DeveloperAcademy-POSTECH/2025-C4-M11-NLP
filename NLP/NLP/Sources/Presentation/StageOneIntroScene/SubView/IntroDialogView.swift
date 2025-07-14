//
//  IntroDialogView.swift
//  NLP
//
//  Created by Ted on 7/14/25.
//

import SwiftUI

struct IntroDialogView: View {
    @State var lineNumber: Int = 1
    @State var dialogsEndAction: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 35) {
            Spacer()
            HStack {
                Spacer()
            }
            ForEach(0..<lineNumber, id: \.self) { index in
                StreamingText(
                    fullDialog: ConstantGameDialogs.introDialogs[index],
                    streamingSpeed: 0.05
                ) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        guard lineNumber < ConstantGameDialogs.introDialogs.count else {
                            // MARK: 다음 화면 전환
                            guard let dialogsEndAction = dialogsEndAction else { return }
                            dialogsEndAction()
                            return
                        }
                        lineNumber += 1
                    }
                }
                .foregroundStyle(.white)
            }
            Spacer()
        }
        .ignoresSafeArea()
        .padding(.horizontal, 20)
        .background(.black)
    }
}
