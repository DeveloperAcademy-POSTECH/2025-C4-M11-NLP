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
            HStack {
                Spacer()
                Button(action: {
                    isPresented = false
                }) {
                    Image(systemName: "x.square.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(.white)
                        .frame(width: 30)
                }
                .buttonStyle(.plain)
                Spacer().frame(width: 24)
            }
            
            Spacer()
            
            //StreamingText View로 텍스트 재활용
            Rectangle()
                .fill(.black.opacity(0.8))
                .frame(width: ConstantScreenSize.screenWidth * 0.9, height: ConstantScreenSize.screenHeight * 0.3)
                .border(Color.yellow, width: 7)
            HStack {
                TextField("", text: $inputText)
                    .font(.system(size: 16, weight: .bold))
                    .padding(.horizontal, 12)
                    .frame(height: 50)
                    .background(Color.black)
                    .foregroundStyle(.white)
                    .overlay(
                        Rectangle().stroke(Color.white, lineWidth: 3)
                    )
                Button {
                    if !dialogManager.isGenerating {
                        dialogManager.respond(inputText, dialogPartnerType: .computer, isLogged: true)
                        inputText = ""
                    }
                    
                } label: {
                    Image(systemName: "arrowshape.up.fill")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 50, height: 50)
                        .background(Color.black)
                        .overlay(
                            Rectangle().stroke(Color.white, lineWidth: 3)
                        )
                }
            }
                .frame(width: ConstantScreenSize.screenWidth * 0.9, height: 50)
                .padding(.bottom, 110) //
            }
        }
    }


