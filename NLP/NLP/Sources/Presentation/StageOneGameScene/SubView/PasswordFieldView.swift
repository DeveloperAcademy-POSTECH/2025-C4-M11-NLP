//
//  PasswordFieldView.swift
//  NLP
//
//  Created by 양시준 on 7/17/25.
//

import SwiftUI

struct PasswordFieldView: View {
    var inputText: String
    var isPasswordIncorrect: Bool
    
    var body: some View {
        ZStack {
            passwordText(inputText)
                .foregroundStyle(isPasswordIncorrect ? .red : .white)
                .frame(maxWidth: .infinity)
                .background(.black.opacity(0.4))
                .padding(4)
                .animation(.easeInOut(duration: 0.2), value: isPasswordIncorrect)
                .overlay(
                    VStack(spacing: 0) {
                        HStack {
                            Rectangle()
                                .frame(width: 16, height: 4)
                            Spacer()
                            Rectangle()
                                .frame(width: 16, height: 4)
                        }
                        .padding(.horizontal, 8)
                        HStack {
                            Rectangle()
                                .frame(width: 4, height: 4)
                            Spacer()
                            Rectangle()
                                .frame(width: 4, height: 4)
                        }
                        .padding(.horizontal, 4)
                        HStack {
                            Rectangle()
                                .frame(width: 4, height: 16)
                            Spacer()
                            Rectangle()
                                .frame(width: 4, height: 16)
                        }
                        Spacer()
                        HStack {
                            Rectangle()
                                .frame(width: 4, height: 16)
                            Spacer()
                            Rectangle()
                                .frame(width: 4, height: 16)
                        }
                        HStack {
                            Rectangle()
                                .frame(width: 4, height: 4)
                            Spacer()
                            Rectangle()
                                .frame(width: 4, height: 4)
                        }
                        .padding(.horizontal, 4)
                        HStack {
                            Rectangle()
                                .frame(width: 16, height: 4)
                            Spacer()
                            Rectangle()
                                .frame(width: 16, height: 4)
                        }
                        .padding(.horizontal, 8)
                    }
                        .foregroundColor(isPasswordIncorrect ? .red : .green)
                )
        }
    }
    
    private func passwordText(_ text: String) -> some View {
        var pwText = text
        if pwText == "door opened" {
            return Text(pwText)
                .font(NLPFont.body)
                .padding()
        }
        
        pwText += String(repeating: "*", count: 4 - text.count)
        return Text(pwText)
            .font(NLPFont.body)
            .kerning(12)
            .padding()
    }
}

#Preview {
    PasswordFieldView(inputText: "123", isPasswordIncorrect: false)
}
