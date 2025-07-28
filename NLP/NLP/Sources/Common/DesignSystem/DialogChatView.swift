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
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .opacity(0.4)
                    .overlay(
                        GeometryReader { _ in
                            ZStack(alignment: .topTrailing) {
                                ScrollViewReader { proxy in
                                    ScrollView {
                                        VStack(alignment: .leading, spacing: 16) {
                                            if let currentPartner = dialogManager.currentPartner, let conversationLogs = dialogManager.conversationLogs[currentPartner] {
                                                if let initialMessage = initialMessage {
                                                    HStack(alignment: .center) {
                                                        StreamingText(fullDialog: initialMessage, streamingSpeed: 0.03, skip: $skipStreaming)
                                                            .font(NLPFont.body)
                                                            .foregroundStyle(NLPColor.label)
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
                                                        .fill(NLPColor.background)
                                                        .strokeBorder(NLPColor.primary, lineWidth: 1)
                                                    )
                                                    .padding(.trailing, 16)
                                                    .id("initial")
                                                }
                                                
                                                ForEach(Array(conversationLogs.enumerated()), id: \.element) { index, log in
                                                    if log.sender == .user {
                                                        HStack {
                                                            Text(log.content)
                                                                .font(NLPFont.body)
                                                                .foregroundStyle(NLPColor.label)
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
                                                            .fill(NLPColor.background)
                                                            .strokeBorder(NLPColor.white, lineWidth: 1)
                                                        )
                                                        .padding(.leading, 20)
                                                        .id("user_\(index)")
                                                    } else {
                                                        HStack(alignment: .center) {
                                                            StreamingText(fullDialog: log.content, streamingSpeed: 0.03, skip: $skipStreaming)
                                                                .font(NLPFont.body)
                                                                .foregroundStyle(NLPColor.label)
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
                                                            .fill(NLPColor.background)
                                                            .strokeBorder(NLPColor.primary, lineWidth: 1)
                                                        )
                                                        .padding(.trailing, 16)
                                                        .id("partner_\(index)")
                                                    }
                                                }
                                                
                                                // 마지막 메시지 후 여백을 위한 투명 뷰
                                                Color.clear
                                                    .frame(height: 1)
                                                    .id("bottom")
                                            }
                                        }
                                        .padding(.top, 16)
                                        .padding(.horizontal, 16)
                                    }
                                    .offset(y: -20) // 스크롤뷰를 20픽셀 위로 올림
                                    .onChange(of: dialogManager.conversationLogs[dialogManager.currentPartner ?? .computer]?.count ?? 0) { _, _ in
                                        // 새 메시지가 추가될 때마다 마지막으로 스크롤
                                        withAnimation(.easeOut(duration: 0.3)) {
                                            proxy.scrollTo("bottom", anchor: .bottom)
                                        }
                                    }
                                    .onAppear {
                                        // 뷰가 나타날 때 마지막으로 스크롤
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            withAnimation(.easeOut(duration: 0.3)) {
                                                proxy.scrollTo("bottom", anchor: .bottom)
                                            }
                                        }
                                    }
                                }
                                XButton(isPresented: $isPresented)
                                    .padding(.trailing, 20)
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
                .background(NLPColor.background)
            }

    }
}

#Preview {
    DialogChatView(
        dialogManager: DialogManager(),
        isPresented: .constant(true)
    )
}
