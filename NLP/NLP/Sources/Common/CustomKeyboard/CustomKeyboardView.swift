//
//  CustomKey.swift
//  NLP
//
//  Created by Gojaehyun on 7/22/25.
//

import SwiftUI

public struct CustomKeyboardView: View {
    @Binding var text: String
    var onCommit: (() -> Void)?
    @State private var inputMode: InputMode = .korean

    public enum InputMode { case korean, english, number, symbol }

    public init(text: Binding<String>, onCommit: (() -> Void)? = nil) {
        self._text = text
        self.onCommit = onCommit
    }

    public var body: some View {
        VStack(spacing: 8) {
            // 입력창
            HStack {
                Text(text)
                    .font(.custom("Galmuri11-Bold", size: 20))
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.black)
            }
            .frame(height: 44)
            // 키보드 모드 전환
            HStack(spacing: 8) {
                Button("한글") { inputMode = .korean }
                    .foregroundColor(inputMode == .korean ? .green : .white)
                Button("영문") { inputMode = .english }
                    .foregroundColor(inputMode == .english ? .green : .white)
                Button("숫자") { inputMode = .number }
                    .foregroundColor(inputMode == .number ? .green : .white)
                Button("기호") { inputMode = .symbol }
                    .foregroundColor(inputMode == .symbol ? .green : .white)
            }
            // 키패드
            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 10), spacing: 6) {
                ForEach(currentKeys, id: \ .self) { key in
                    Button(action: {
                        handleKeyPress(key)
                    }) {
                        Text(key)
                            .font(.custom("Galmuri11-Bold", size: 18))
                            .foregroundColor(.white)
                            .frame(height: 38)
                            .frame(maxWidth: .infinity)
                            .background(Color.clear)
                            .overlay(
                                Rectangle()
                                    .stroke(Color.green, lineWidth: 2)
                            )
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
    }

    private var currentKeys: [String] {
        switch inputMode {
        case .korean:
            return ["ㅂ","ㅈ","ㄷ","ㄱ","ㅅ","ㅛ","ㅕ","ㅑ","ㅐ","ㅔ",
                    "ㅁ","ㄴ","ㅇ","ㄹ","ㅎ","ㅗ","ㅓ","ㅏ","ㅣ","←",
                    "ㅋ","ㅌ","ㅊ","ㅍ","ㅠ","ㅜ","ㅡ","Space","Enter"]
        case .english:
            return ["q","w","e","r","t","y","u","i","o","p",
                    "a","s","d","f","g","h","j","k","l","←",
                    "z","x","c","v","b","n","m","Space","Enter"]
        case .number:
            return ["1","2","3","4","5","6","7","8","9","0",
                    "-","/",":",";","(",")","$","&","@","\"",
                    ".",",","?","!","'","Space","Enter"]
        case .symbol:
            return ["[","]","{","}","#","%","^","*","+","=",
                    "_","\\","|","~","<",">","€","£","¥","•",
                    ".",",","?","!","'","Space","Enter"]
        }
    }

    private func handleKeyPress(_ key: String) {
        switch key {
        case "←":
            if !text.isEmpty { text.removeLast() }
        case "Space":
            text += " "
        case "Enter":
            onCommit?()
        default:
            text += key
        }
    }
} 
