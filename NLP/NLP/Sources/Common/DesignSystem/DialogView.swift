//
//  DialogView.swift
//  SpriteKitExample
//
//  Created by 한건희 on 7/9/25.
//

import SwiftUI

struct DialogView: View {
    @ObservedObject var dialogManager: DialogManager
    @Binding var isPresented: Bool
    @State var inputText: String = ""

    
    
    var body: some View {
        VStack {
            Spacer().frame(height: 50)
            
            BackgroundView(isPresented: $isPresented)
                .overlay(
                    ScrollView{
                        VStack(alignment: .leading, spacing: 5){
                            if let partner = dialogManager.currentPartner {
                                ForEach(dialogManager.conversationLogs[partner] ?? [], id: \.self) { dialog in
                                    if (dialog.sender == .user){
                                        Text(dialog.content)
                                            .font(NLPFont.body)
                                            .foregroundStyle(.white)
                                    } else {
                                        StreamingText(fullDialog:dialog.content, streamingSpeed: 0.05)
                                            .font(NLPFont.body)
                                            .foregroundStyle(.white)
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading) // 추가 보장
                        
                        TextField("내용을 입력", text: $inputText)
                            .font(NLPFont.body)
                            .foregroundStyle(.red)
                            .textFieldStyle(.plain) // 깔끔한 스타일 (원하면 수정)
                            .submitLabel(.done)      // 키보드의 return 키에 "Done" 표시 (필요시 다른 옵션도 가능)
                            .onSubmit {
                                dialogManager.respond(inputText, dialogPartnerType: dialogManager.currentPartner ?? .computer, isLogged: true)
                                inputText = ""       // 입력 후 초기화
                            }
                    }
                    .frame(
                        width: ConstantScreenSize.screenWidth * 0.82,
                        height: ConstantScreenSize.screenHeight * 0.4
                    )
                    .border(Color.green)

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
            .frame(width: ConstantScreenSize.screenWidth * 0.9, height: ConstantScreenSize.screenHeight * 0.5)
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


