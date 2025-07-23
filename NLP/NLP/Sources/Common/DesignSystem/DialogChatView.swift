//
//  DialogChatView.swift
//  NLP
//
//  Created by 양시준 on 7/21/25.
//

import SwiftUI

// DialogItem enum 삭제 (중복 선언 제거)
struct DialogChatView: View {
    @ObservedObject var dialogManager: DialogManager
    @Binding var isPresented: Bool
    @State var inputText: String = ""
    @FocusState private var isFocused: Bool
    @State var showCursor: Bool = true
    @State private var skipStreaming: Bool = false

    // 타이머로 커서 깜빡임 제어
    let cursorTimer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()

    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color.black.opacity(0.4))
                .ignoresSafeArea(.all)
            Rectangle()
                .foregroundStyle(Color.clear)
                .frame(maxWidth: ConstantScreenSize.screenWidth * 0.9, maxHeight: ConstantScreenSize.screenHeight * 0.8)
                .overlay(
                    GeometryReader { geometry in
                        ZStack(alignment: .topTrailing) {
                            ScrollView {
                                VStack(alignment: .leading, spacing: 16) {
                                    if let currentPartner = dialogManager.currentPartner, let conversationLogs = dialogManager.conversationLogs[currentPartner] {
                                        ForEach(Array(conversationLogs.enumerated()), id: \ .element) { idx, log in
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
                                                    // 마지막 AI 메시지에만 '다음' 버튼 표시
                                                    if idx == conversationLogs.count - 1 {
                                                        Button(action: {
                                                            skipStreaming = true
                                                        }) {
                                                            Text("다음")
                                                                .font(.custom("Galmuri11-Bold", size: 18))
                                                                .foregroundColor(.white)
                                                                .padding(.horizontal, 16)
                                                                .padding(.vertical, 8)
                                                                .background(Color.green.opacity(0.7))
                                                                .cornerRadius(8)
                                                        }
                                                        .padding(.trailing, 8)
                                                    }
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
                                    
                                    UserDialogInputField(
                                        inputText: $inputText,
                                        showCursor: $showCursor,
                                        isFocused: _isFocused,
                                        submitAction: {
                                            dialogManager.respond(
                                                inputText,
                                                dialogPartnerType: dialogManager.currentPartner ?? .computer,
                                                isLogged: true
                                            )
                                            inputText = ""
                                        }
                                    )
                                    .padding(8)
                                    .background(Color.black.opacity(0.2))
                                    .padding(.bottom, 12)
                                    .frame(maxWidth: .infinity)
                                }
                                .onReceive(cursorTimer) { _ in
                                    showCursor.toggle()
                                }
                            }
                            .defaultScrollAnchor(.bottom)
                            XButton(isPresented: $isPresented)
                                .padding([.top, .trailing], 16)
                        }
                    }
                )
        }
    }
}


#Preview {
    DialogChatView(
        dialogManager: DialogManager(),
        isPresented: .constant(true)
    )
}
