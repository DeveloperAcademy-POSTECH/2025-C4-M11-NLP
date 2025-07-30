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
        VStack {
            RightXButton(isPresented: $isPresented)
                .padding(.bottom, 20)
            if let currentPartner = dialogManager.currentPartner, let logs = dialogManager.conversationLogs[currentPartner] {
                ScrollViewReader { proxy in
                    ScrollView {
                        ForEach(logs, id: \.self) { log in
                            ChatbotBubble(
                                skipStreaming: $skipStreaming,
                                log: log
                            )
                        }
                        Spacer().frame(height: 50)
                            .id(ConstantValues.scrollViewBottom)
                    }
                    .onChange(of: logs) { _, _ in
                        withAnimation {
                            proxy.scrollTo(ConstantValues.scrollViewBottom, anchor: .bottom)
                        }
                    }
                }
            }
            CustomKeyboardView(
                text: $inputText,
                onCommit: {
                    dialogManager.respond(
                        inputText,
                        dialogPartnerType: dialogManager.currentPartner ?? .oxygen,
                        isLogged: true
                    )
                    inputText = ""
                    onSend?()
                }
            )
            .background(.black)
        }
    }
}

struct ChatbotBubble: View {
    @Binding var skipStreaming: Bool
    var log: Dialog
    
    var body: some View {
        HStack {
            StreamingText(fullDialog: log.content, streamingSpeed: 0.03, skip: $skipStreaming)
                .font(NLPFont.body)
                .frame(width: ConstantScreenSize.screenWidth / 3 * 2)
                .padding(.horizontal, 10)
                .padding(.vertical, 15)
                .background(
                    RoundedCorners(radius: 10, corners: log.sender == .partner ? [.topLeft, .topRight, .bottomRight] : [.topLeft, .topRight, .bottomLeft])
                        .stroke(log.sender == .partner ? .green : .white)
                )
                .padding(log.sender == .partner ? .trailing : .leading, 24)
        }
    }
}

#Preview {
    DialogChatView(
        dialogManager: DialogManager(),
        isPresented: .constant(true)
    )
}
