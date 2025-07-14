//
//  GameButton.swift
//  NLP
//
//  Created by Ted on 7/14/25.
//

import SwiftUI

struct GameButton: View {
    @State var buttonText: String
    var buttonWidth: CGFloat?
    var buttonHeight: CGFloat
    var buttonTapAction: (() -> Void)?
    
    init(
        buttonText: String,
        buttonWidth: CGFloat? = nil,
        buttonHeight: CGFloat = 44,
        buttonTapAction: (() -> Void)? = nil
    ) {
        self.buttonText = buttonText
        self.buttonWidth = buttonWidth
        self.buttonHeight = buttonHeight
        self.buttonTapAction = buttonTapAction
    }
    
    var body: some View {
        Button(action: {
            guard let buttonTapAction = buttonTapAction else { return }
            buttonTapAction()
        }) {
            Rectangle()
                .stroke(.white, lineWidth: 5)
                .background(.black)
                .frame(
                    width: buttonWidth,
                    height: buttonHeight
                )
                .overlay(
                    Text(buttonText)
                        .foregroundStyle(.white)
                )
        }
        .buttonStyle(.plain)
    }
}
