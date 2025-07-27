//
//  DialogChatView.swift
//  SpriteKitExample
//
//  Created by 양시준 on 7/21/25.
//

import SwiftUI

// DialogItem enum 삭제 (중복 선언 제거)
struct DialogChatView: View {
    @ObservedObject var dialogManager: DialogManager
    @Binding var isPresented: Bool
    @State var inputText: String = ""
    @State private var skipStreaming: Bool = false
    var onSend: (() -> Void)? = nil
    var initialMessage: String? = nil // 초기 메시지 추가

    var body: some View {

            VStack{
                Spacer()
                Rectangle()
                    .frame(width: ConstantScreenSize.screenWidth*0.9 ,height: ConstantScreenSize.screenHeight * 0.5)
                    .opacity(0.4)
                    .overlay(
                        GeometryReader { _ in
                            ZStack(alignment: .topTrailing) {
                                ScrollView {
                                    VStack(alignment: .leading, spacing: 16) {
                                        if let currentPartner = dialogManager.currentPartner, let conversationLogs = dialogManager.conversationLogs[currentPartner] {
                                            if let initialMessage = initialMessage {
                                                HStack(alignment: .center) {
                                                    StreamingText(fullDialog: initialMessage, streamingSpeed: 0.03, skip: $skipStreaming)
                                                        .font(NLPFont.body)
                                                        .foregroundStyle(.white)
                                                        .padding(20)
                                                    Spacer()
                                                }
                                                .background(
                                                    UnevenRoundedRectangle(
                                                        topLeadingRadius: 16,
                                                        bottomLeadingRadius: 0,
                                                        bottomTrailingRadius: 16,
                                                        topTrailingRadius: 16
                                                    )
                                                    .fill(Color.black.opacity(0.6))
                                                    .strokeBorder(NLPColor.green, lineWidth: 1)
                                                )
                                                .padding(.trailing, 16)
                                            }
                                            
                                            ForEach(Array(conversationLogs.enumerated()), id: \ .element) { _, log in
                                                if log.sender == .user {
                                                    HStack {
                                                        Text(log.content)
                                                            .font(NLPFont.body)
                                                            .foregroundStyle(.white)
                                                            .padding(16)
                                                        Spacer()
                                                    }
                                                    .background(
                                                        UnevenRoundedRectangle(
                                                            topLeadingRadius: 16,
                                                            bottomLeadingRadius: 16,
                                                            bottomTrailingRadius: 0,
                                                            topTrailingRadius: 16
                                                        )
                                                        .fill(Color.black.opacity(0.6))
                                                        .strokeBorder(Color.white, lineWidth: 1)
                                                    )
                                                    .padding(.leading, 20)
                                                } else {
                                                    HStack(alignment: .center) {
                                                        StreamingText(fullDialog: log.content, streamingSpeed: 0.03, skip: $skipStreaming)
                                                            .font(NLPFont.body)
                                                            .foregroundStyle(.white)
                                                            .padding(20)
                                                        Spacer()
                                                    }
                                                    .background(
                                                        UnevenRoundedRectangle(
                                                            topLeadingRadius: 16,
                                                            bottomLeadingRadius: 0,
                                                            bottomTrailingRadius: 16,
                                                            topTrailingRadius: 16
                                                        )
                                                        .fill(Color.black.opacity(0.6))
                                                        .strokeBorder(NLPColor.green, lineWidth: 1)
                                                    )
                                                    .padding(.trailing, 16)
                                                }
                                            }
                                        }
                                    }
                                }
                                XButton(isPresented: $isPresented)
                            }
                        }
                    )
                // 키보드는 화면 전체 너비로 하단에 고정
                Spacer()
                VStack{
                    CustomKeyboardView(
                        text: $inputText,
                        onCommit: {
                            dialogManager.respond(
                                inputText,
                                dialogPartnerType: dialogManager.currentPartner ?? .oxygen,
                                isLogged: true
                            )
                            print("dialogManager.currentPartner is \(dialogManager.currentPartner)")
                            inputText = ""
                            onSend?()
                        }
                    )
                }
                .frame(maxWidth: .infinity)
                .background(Color.black.opacity(0.4))
            }

    }
}

#Preview {
    DialogChatView(
        dialogManager: DialogManager(),
        isPresented: .constant(true)
    )
}
