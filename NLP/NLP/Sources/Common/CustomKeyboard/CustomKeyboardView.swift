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
                    .padding(.vertical, 14)
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
            }
            // 하단: 한/영, 스페이스(길게), Shift
            HStack(spacing: 8) {
                Button(action: { toggleInputMode() }) {
                    Text(inputMode == .korean ? "한/영" : "영/한")
                        .font(.custom("Galmuri11-Bold", size: 18))
                        .foregroundColor(.white)
                        .frame(width: 60, height: 38)
                        .background(Color.clear)
                        .overlay(Rectangle().stroke(Color.green, lineWidth: 2))
                }
                Button(action: { onKeyPress("Space") }) {
                    Text("Space")
                        .font(.custom("Galmuri11-Bold", size: 18))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 38)
                        .background(Color.clear)
                        .overlay(Rectangle().stroke(Color.green, lineWidth: 2))
                }
                Button(action: { toggleShift() }) {
                    Text("Shift")
                        .font(.custom("Galmuri11-Bold", size: 18))
                        .foregroundColor(isShifted ? .green : .white)
                        .frame(width: 60, height: 38)
                        .background(Color.clear)
                        .overlay(Rectangle().stroke(Color.green, lineWidth: 2))
                }
            }
            .frame(height: 38)
        }
    }

    // 키패드 행별 배열
    private var keyRows: [[String]] {
        switch inputMode {
        case .korean:
            return [
                ["ㅂ","ㅈ","ㄷ","ㄱ","ㅅ","ㅛ","ㅕ","ㅑ","ㅐ","ㅔ"],
                ["ㅁ","ㄴ","ㅇ","ㄹ","ㅎ","ㅗ","ㅓ","ㅏ","ㅣ","←"],
                ["ㅋ","ㅌ","ㅊ","ㅍ","ㅠ","ㅜ","ㅡ","Enter"]
            ]
        case .english:
            let row1 = isShifted ? ["Q","W","E","R","T","Y","U","I","O","P"] : ["q","w","e","r","t","y","u","i","o","p"]
            let row2 = isShifted ? ["A","S","D","F","G","H","J","K","L","←"] : ["a","s","d","f","g","h","j","k","l","←"]
            let row3 = isShifted ? ["Z","X","C","V","B","N","M","Enter"] : ["z","x","c","v","b","n","m","Enter"]
            return [row1, row2, row3]
        case .number:
            return [
                ["1","2","3","4","5","6","7","8","9","0"],
                ["-","/",":",";","(",")","$","&","@","\""],
                [".",",","?","!","'","Enter","←"]
            ]
        case .symbol:
            return [
                ["[","]","{","}","#","%","^","*","+","="],
                ["_","\\","|","~","<",">","€","£","¥","•"],
                [".",",","?","!","'","Enter","←"]
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
        if inputMode == .english {
            isShifted.toggle()
        }
    }

    private func onKeyPress(_ key: String) {
        if inputMode == .korean {
            if isHangulJamo(key) {
                jamoBuffer.append(key)
            } else if key == "←" {
                onBackspace()
                return
            } else if key == "Space" {
                commitBuffer()
                insert(" ")
                return
            } else if key == "Enter" {
                commitBuffer()
                onCommit?()
                return
            } else {
                commitBuffer()
                insert(key)
                return
            }
            // 입력창 업데이트
            updateInput()
        } else {
            // 영문/숫자/기호 모드
            if key == "←" {
                onBackspace()
            } else if key == "Space" {
                insert(" ")
            } else if key == "Enter" {
                onCommit?()
            } else {
                insert(key)
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
