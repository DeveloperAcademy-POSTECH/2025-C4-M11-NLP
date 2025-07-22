//
//  CustomKey.swift
//  NLP
//
//  Created by Gojaehyun on 7/22/25.
//

import SwiftUI
import Foundation

public struct CustomKeyboardView: View {
    @Binding var text: String
    var onCommit: (() -> Void)?
    @State private var inputMode: InputMode = .korean
    @State private var jamoBuffer: [String] = [] // 한글 자모 버퍼
    @State private var isShifted: Bool = false // Shift 상태

    public enum InputMode { case korean, english, number, symbol }

    public init(text: Binding<String>, onCommit: (() -> Void)? = nil) {
        self._text = text
        self.onCommit = onCommit
    }

    public var body: some View {
        VStack(spacing: 8) {
            // 입력창
            HStack {
                Text(text + HangulComposer.compose(jamoBuffer))
                    .font(.custom("Galmuri11-Bold", size: 20))
                    .foregroundColor(.white)
                    .padding(.vertical, 18)
                    .padding(.horizontal, 12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.black)
            }
            .frame(height: 44)
            // 키패드 (3~4줄)
            ForEach(keyRows, id: \ .self) { row in
                HStack(spacing: 6) {
                    ForEach(row, id: \ .self) { key in
                        Button(action: {
                            onKeyPress(key)
                        }) {
                            Text(displayKey(key))
                                .font(.custom("Galmuri11-Bold", size: 18))
                                .foregroundColor(.white)
                                .frame(height: 45)
                                .frame(maxWidth: .infinity)
                                .background(Color.clear)
                                .overlay(
                                    Rectangle()
                                        .stroke(Color.green, lineWidth: 2)
                                )
                        }
                    }
                }
            }
            // 하단: 한/영, 스페이스(길게), 특수문자 전환
            HStack(spacing: 8) {
                Button(action: { toggleInputMode() }) {
                    Text(inputMode == .korean ? "한/영" : "영/한")
                        .font(.custom("Galmuri11", size: 18))
                        .foregroundColor(.white)
                        .frame(width: 60, height: 45)
                        .background(Color.clear)
                        .overlay(Rectangle().stroke(Color.green, lineWidth: 2))
                }
                Button(action: { onKeyPress("Space") }) {
                    Text("Space")
                        .font(.custom("Galmuri11-Bold", size: 18))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 45)
                        .background(Color.clear)
                        .overlay(Rectangle().stroke(Color.green, lineWidth: 2))
                }
                // 특수문자 전환 버튼
                Button(action: { toggleSymbolMode() }) {
                    Text(inputMode == .symbol ? "ABC" : "#?")
                        .font(.custom("Galmuri11-Bold", size: 18))
                        .foregroundColor(inputMode == .symbol ? .green : .white)
                        .frame(width: 60, height: 45)
                        .background(Color.clear)
                        .overlay(Rectangle().stroke(Color.green, lineWidth: 2))
                }
            }
            .frame(height: 45)
        }
    }

    // 키패드 행별 배열
    private var keyRows: [[String]] {
        switch inputMode {
        case .korean:
            let isShifted = self.isShifted
            let row1 = isShifted ? ["ㅃ","ㅉ","ㄸ","ㄲ","ㅆ","ㅛ","ㅕ","ㅑ","ㅒ","ㅖ"] : ["ㅂ","ㅈ","ㄷ","ㄱ","ㅅ","ㅛ","ㅕ","ㅑ","ㅐ","ㅔ"]
            let row2 = ["ㅁ","ㄴ","ㅇ","ㄹ","ㅎ","ㅗ","ㅓ","ㅏ","ㅣ","←"]
            let row3 = ["⇧","ㅋ","ㅌ","ㅊ","ㅍ","ㅠ","ㅜ","ㅡ"," ↵ "]
            return [row1, row2, row3]
        case .english:
            let row1 = isShifted ? ["Q","W","E","R","T","Y","U","I","O","P"] : ["q","w","e","r","t","y","u","i","o","p"]
            let row2 = isShifted ? ["A","S","D","F","G","H","J","K","L","←"] : ["a","s","d","f","g","h","j","k","l","←"]
            // 3번째 줄: ⇧, z, x, c, v, b, n, m, ↵
            let row3 = (isShifted ? ["⇧","Z","X","C","V","B","N","M"," ↵ "] : ["⇧","z","x","c","v","b","n","m"," ↵ "])
            return [row1, row2, row3]
        case .number:
            return [
                ["1","2","3","4","5","6","7","8","9","0"],
                ["-","/",":",";","(",")","$","&","@","\""],
                [".",",","?","!","'"," ↵ ","←"]
            ]
        case .symbol:
            return [
                ["[","]","{","}","#","%","^","*","+","="],
                ["_","\\","|","~","<",">","€","£","¥","•"],
                [".",",","?","!","'"," ↵ ","←"]
            ]
        }
    }

    private func displayKey(_ key: String) -> String {
        key
    }

    private func toggleInputMode() {
        if inputMode == .korean {
            inputMode = .english
        } else if inputMode == .english {
            inputMode = .korean
        } else {
            inputMode = .korean
        }
        isShifted = false
    }

    private func toggleShift() {
        if inputMode == .english || inputMode == .korean {
            isShifted.toggle()
        }
    }

    private func toggleSymbolMode() {
        if inputMode == .symbol {
            inputMode = .english
        } else {
            inputMode = .symbol
        }
        isShifted = false
    }

    private func onKeyPress(_ key: String) {
        if inputMode == .korean {
            if key == "⇧" {
                toggleShift()
                return
            }
            if isHangulJamo(key) {
                jamoBuffer.append(key)
            } else if key == "←" {
                onBackspace()
                return
            } else if key == "Space" {
                commitBuffer()
                insert(" ")
                return
            } else if key == "Enter" || key == " ↵ " {
                commitBuffer()
                onCommit?()
                return
            } else {
                commitBuffer()
                if key != " ↵ " && key != "Enter" {
                    insert(key)
                }
                return
            }
            // 입력창 업데이트
            updateInput()
        } else {
            // 영문/숫자/기호 모드
            if key == "⇧" {
                toggleShift()
                return
            }
            if key == "←" {
                onBackspace()
            } else if key == "Space" {
                insert(" ")
            } else if key == "Enter" || key == " ↵ " {
                onCommit?()
            } else {
                if key != " ↵ " && key != "Enter" {
                    insert(key)
                }
            }
        }
    }

    private func commitBuffer() {
        let composed = HangulComposer.compose(jamoBuffer)
        insert(composed)
        jamoBuffer.removeAll()
    }

    private func onBackspace() {
        if !jamoBuffer.isEmpty {
            jamoBuffer.removeLast()
            updateInput()
        } else {
            deletePreviousCharacter()
        }
    }

    private func updateInput() {
        // 입력창에 조합 중인 글자 표시 (text + 조합중)
        // text는 확정된 글자, jamoBuffer는 조합중
        // 이미 body에서 text + HangulComposer.compose(jamoBuffer)로 표시
    }

    private func insert(_ str: String) {
        guard !str.isEmpty else { return }
        text += str
    }

    private func deletePreviousCharacter() {
        if !text.isEmpty {
            text.removeLast()
        }
    }

    private func isHangulJamo(_ key: String) -> Bool {
        let jamoSet = "ㄱㄲㄴㄷㄸㄹㅁㅂㅃㅅㅆㅇㅈㅉㅊㅋㅌㅍㅎㅏㅐㅑㅒㅓㅔㅕㅖㅗㅘㅙㅚㅛㅜㅝㅞㅟㅠㅡㅢㅣ"
        return jamoSet.contains(key)
    }
} 
