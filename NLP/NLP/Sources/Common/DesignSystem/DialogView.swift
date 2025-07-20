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
                                Text(log.content)
                                    .font(NLPFont.body)
                                    .foregroundStyle(.white)
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
    }
}


#Preview {
    DialogView(
        dialogManager: DialogManager(),
        isPresented: .constant(true)
    )
}


