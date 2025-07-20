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

    
    
    var body: some View {
        VStack {
            Spacer().frame(height: 50)
            
            BackgroundView(isPresented: $isPresented)
                .overlay(
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0) {
                            ForEach(Array(dialogManager.logsAndInputs.enumerated()), id: \.offset) { index, item in
                                switch item {
                                case .message(let dialog):
                                    if dialog.sender == .user {
                                        Text(dialog.content)
                                            .font(NLPFont.body)
                                            .foregroundStyle(.white)
                                    } else {
                                        StreamingText(fullDialog: dialog.content, streamingSpeed: 0.05)
                                            .font(NLPFont.body)
                                            .foregroundStyle(.white)
                                    }
                                case .input:
                                    if !dialogManager.isGenerating {
                                        ZStack(alignment: .leading) {
                                            if inputText.isEmpty && !isFocused {
                                                Text("입력해주세요")
                                                    .foregroundColor(.gray)
                                                    .font(NLPFont.body)
                                                    .padding(.leading, 4)
                                            }
                                            TextField("", text: $inputText)
                                                .font(NLPFont.body)
                                                .foregroundStyle(.white)
                                                .focused($isFocused)
                                                .submitLabel(.send)
                                                .onSubmit {
                                                    if !inputText.isEmpty {
                                                        dialogManager.respond(inputText, dialogPartnerType: dialogManager.currentPartner ?? .computer, isLogged: true)
                                                        inputText = ""
                                                    }
                                                }
                                        }
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(
                        width: ConstantScreenSize.screenWidth * 0.82,
                        height: ConstantScreenSize.screenHeight * 0.36
                    )
                    .border(.gray)
                )

            

//            HStack {
//                TextField("", text: $inputText)
//                    .font(NLPFont.body)
//                    .padding(.horizontal, 12)
//                    .frame(height: 50)
//                    .background(Color.black)
//                    .foregroundStyle(.white)
//                    .overlay(
//                        Rectangle().stroke(Color.white, lineWidth: 3)
//                    )
//                Button {
//                    if !dialogManager.isGenerating {
//                        dialogManager.respond(inputText, dialogPartnerType: dialogManager.currentPartner ?? .computer, isLogged: true)
//                        inputText = ""
//                    }
//                    
//                } label: {
//                    Image(systemName: "arrowshape.up.fill")
//                        .font(.system(size: 24, weight: .bold))
//                        .foregroundStyle(.white)
//                        .frame(width: 50, height: 50)
//                        .background(Color.black)
//                        .overlay(
//                            Rectangle().stroke(Color.white, lineWidth: 3)
//                        )
//                }
//            }
//                .frame(width: ConstantScreenSize.screenWidth * 0.9, height: 50)
//                .padding(.bottom, 110) //
        }
    }
}


struct BackgroundView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
                  
        Rectangle()
            .opacity(0.1)
            .frame(width: ConstantScreenSize.screenWidth * 0.9, height: ConstantScreenSize.screenHeight * 0.45)
            .border(Color.yellow, width: 1)
            .overlay {
                GeometryReader { geometry in
                    ZStack {
                        Button {
                            isPresented = false
                        } label: {
                            Image("x-symbol")
                                .resizable()
                                .frame(width: 24, height:24)
                                .position(x: geometry.size.width - 27, y: 27)
                        }
                
                        Image("dialogView-LT")
                            .resizable()
                            .frame(width: 20, height:20)
                            .position(x: 7, y: 7)
                        
                        Image("dialogView-RT")
                            .resizable()
                            .frame(width: 20, height:20)
                            .position(x: geometry.size.width - 7, y: 7)
                        
                        Image("dialogView-LD")
                            .resizable()
                            .frame(width: 20, height:20)
                            .position(x: 7, y: geometry.size.height - 7)
                        
                        Image("dialogView-RD")
                            .resizable()
                            .frame(width: 20, height:20)
                            .position(x: geometry.size.width - 7, y: geometry.size.height - 7)
                    }
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


