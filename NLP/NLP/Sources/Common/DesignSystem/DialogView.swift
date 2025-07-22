//
//  DialogView.swift
//  SpriteKitExample
//
//  Created by 한건희 on 7/9/25.
//

import SwiftUI

// DialogItem enum 삭제 (중복 선언 제거)
struct DialogView: View {
    @ObservedObject var dialogManager: DialogManager
    @Binding var isPresented: Bool
    @State var inputText: String = ""
    @FocusState private var isFocused: Bool
    @State var showCursor: Bool = true

    // 타이머로 커서 깜빡임 제어
    let cursorTimer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()

    
    var body: some View {
        ZStack(alignment: .bottom) {
            // 대화창(배경 + 로그)
            DialogBackgroundView(isPresented: $isPresented)
                .overlay(
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            if let currentPartner = dialogManager.currentPartner, let conversationLogs = dialogManager.conversationLogs[currentPartner] {
                                ForEach(conversationLogs, id: \.self) { log in
                                    if log.sender == .user {
                                        Text(log.content)
                                            .font(NLPFont.body)
                                            .foregroundStyle(.white)
                                    } else {
                                        StreamingText(fullDialog: log.content, streamingSpeed: 0.03)
                                            .font(NLPFont.body)
                                            .foregroundStyle(.white)
                                    }
                                }
                            }
                        }
                        .padding(.top, 12)
                        .padding(.horizontal, 8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                )
                .padding(.bottom, 320) // 입력창+키보드 높이만큼 충분히 크게 패딩
            // 하단 고정: 입력창 + 커스텀 키보드 (한 번만)
            VStack(spacing: 0) {
                CustomKeyboardView(text: $inputText, onCommit: {
                    dialogManager.respond(
                        inputText,
                        dialogPartnerType: dialogManager.currentPartner ?? .computer,
                        isLogged: true
                    )
                    inputText = ""
                })
            }
            // XButton을 최상단에 오버레이로 배치
            VStack {
                HStack {
                    Spacer()
                    XButton(isPresented: $isPresented)
                        .padding([.top, .trailing], 16)
                }
                Spacer()
            }
            .allowsHitTesting(true)
            .zIndex(1)
        }
        .onChange(of: isPresented) { newValue in
            if !newValue {
                isFocused = false // X 버튼 등으로 닫힐 때 키보드 내리기
            }
        }
    }
}


#Preview {
    DialogView(
        dialogManager: DialogManager(),
        isPresented: .constant(true)
    )
}
