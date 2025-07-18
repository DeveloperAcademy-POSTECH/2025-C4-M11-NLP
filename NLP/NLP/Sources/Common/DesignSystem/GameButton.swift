//
//  GameButton.swift
//  NLP
//
//  Created by Ted on 7/14/25.
//

import SwiftUI

/**
 게임에서 사용할 커스텀 버튼 뷰입니다.
 
 - 버튼은 흰색 테두리, 검은색 배경, 흰색 텍스트로 구성됩니다.
 - 버튼이 눌리면 `buttonTapAction` 클로저가 실행됩니다.
 */
struct GameButton: View {
    
    /**
     버튼에 표시할 텍스트입니다.
     */
    @State var buttonText: String
    
    /**
     버튼의 너비입니다. 기본값은 `nil`이며, 지정하지 않으면 자동으로 크기가 조정됩니다.
     */
    var buttonWidth: CGFloat?
    
    /**
     버튼의 높이입니다. 기본값은 `44`입니다.
     */
    var buttonHeight: CGFloat
    
    /**
     버튼이 탭되었을 때 실행할 액션입니다. 기본값은 `nil`입니다.
     */
    var buttonTapAction: (() -> Void)?
    
    /**
     `GameButton` 초기화 메서드입니다.
     
     - Parameters:
        - buttonText: 버튼에 표시할 텍스트입니다.
        - buttonWidth: 버튼의 너비입니다. 기본값은 `nil`입니다.
        - buttonHeight: 버튼의 높이입니다. 기본값은 `44`입니다.
        - buttonTapAction: 버튼이 눌렸을 때 실행할 액션입니다. 기본값은 `nil`입니다.
     */
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
            /** 버튼이 눌렸을 때 지정된 액션을 실행합니다. */
            guard let buttonTapAction = buttonTapAction else { return }
            buttonTapAction()
        }) {
            /** 버튼의 시각적 UI입니다. */
            VStack(spacing: 2) {
                Text("\(buttonText) >")
                    .font(NLPFont.body)
                    .foregroundStyle(.white)
                    .padding(.bottom, 2)
                    .underline()
//                    .background(
//                        VStack {
//                            Spacer()
//                            Rectangle()
//                                .fill(.white)
//                                .frame(height: 1)
//                        }
//                    )
            }
        }
        .buttonStyle(.plain) /** 기본 버튼 스타일 제거 */
    }
}
