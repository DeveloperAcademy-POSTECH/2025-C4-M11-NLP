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
                        
                        
                    }
                    .onReceive(cursorTimer) { _ in
                        showCursor.toggle()
                    }
                }
                .frame(
                    width: ConstantScreenSize.screenWidth * 0.82,
                    height: ConstantScreenSize.screenHeight * 0.36
                )
            )
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


