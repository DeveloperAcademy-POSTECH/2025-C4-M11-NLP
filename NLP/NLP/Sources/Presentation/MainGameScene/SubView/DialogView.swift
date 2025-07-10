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
            
            Rectangle()
                .fill(.black.opacity(0.3))
                .frame(width: ConstantValues.screenWidth, height: ConstantValues.screenHeight / 2)
                .overlay(
                    VStack(spacing: 10) {
                        ScrollView {
                            if let currentPartner = dialogManager.currentPartner {
                                VStack(spacing: 10) {
                                    ForEach(dialogManager.conversationLogs[currentPartner] ?? [], id: \.self) { dialog in
                                        Text(dialog.content)
                                            .foregroundStyle(.white)
                                            .frame(width: ConstantValues.screenWidth - 40)
                                            .padding(.all, 8)
                                            .multilineTextAlignment(.leading)
                                            .background(
                                                Rectangle()
                                                    .fill(.black)
                                                    .stroke(.white, lineWidth: 8)
                                            )
                                    }
                                }
                            }
                        }
                        HStack(spacing: 10) {
                            Rectangle()
                                .fill(.black)
                                .stroke(.white, lineWidth: 8)
                                .overlay(
                                    TextField("", text: $inputText)
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 10)
                                )
                            
                            Rectangle()
                                .fill(.black)
                                .stroke(.white, lineWidth: 8)
                                .frame(width: 40)
                                .onTapGesture {
                                    if !dialogManager.isGenerating {
                                        dialogManager.respond(inputText, dialogPartnerType: .computer, isLogged: true)
                                        inputText = ""
                                    }
                                }
                        }
                        .frame(height: 40)
                        .padding(.horizontal, 24)
                    }
                )
                .padding(.bottom, 40)
        }
    }
}


