//
//  CustomKey.swift
//  NLP
//
//  Created by Gojaehyun on 7/22/25.
//

import SwiftUI
import Foundation
import UIKit

import Combine

public struct CustomKeyboardView: View {
    @Binding var text: String
    var onCommit: (() -> Void)?
    @State private var inputMode: InputMode = .korean
    @State private var jamoBuffer: [String] = [] // 한글 자모 버퍼
    @State private var isShifted: Bool = false // Shift 상태
    @State private var backspaceTimer: Timer? = nil
    @State private var isPressingBackspace: Bool = false
    @State private var showCursor: Bool = true
    @State private var cursorTimer: Timer? = nil

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
                    .background(
                        Rectangle()
                            .fill(Color.black)
                            .overlay(
                                Rectangle()
                                    .stroke(Color.green, lineWidth: 2)
                            )
                    )
                    .overlay(
                        // 커서 효과
                        VStack {
                            Spacer()
                            HStack {
                                if text.isEmpty && jamoBuffer.isEmpty {
                                    Rectangle()
                                        .fill(Color.white)
                                        .frame(width: 20, height: 2)
                                        .opacity(showCursor ? 1 : 0)
                                        .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: showCursor)
                                }
                                Spacer()
                            }
                            .padding(.leading, 12)
                            .padding(.bottom, 8)
                        }
                    )
            }
            .frame(height: 44)
            .onAppear {
                startCursorBlink()
            }
            .onDisappear {
                stopCursorBlink()
                stopBackspaceTimer()
            }
            // 키패드 (3~4줄)
            ForEach(keyRows, id: \ .self) { row in
                HStack(spacing: 6) {
                    ForEach(row, id: \ .self) { key in
                        if key == "←" {
                            Button(action: {
                                onBackspace()
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
                            .simultaneousGesture(
                                LongPressGesture(minimumDuration: 0.4)
                                    .onEnded { _ in
                                        isPressingBackspace = true
                                        startBackspaceTimer()
                                    }
                            )
                            .onChange(of: isPressingBackspace) { isPressing in
                                if !isPressing {
                                    stopBackspaceTimer()
                                }
                            }
                            .gesture(
                                DragGesture(minimumDistance: 0)
                                    .onEnded { _ in
                                        isPressingBackspace = false
                                    }
                            )
                            .onLongPressGesture(minimumDuration: 0, pressing: { pressing in
                                if !pressing {
                                    isPressingBackspace = false
                                }
                            }, perform: {})
                        } else if key == "#?" || key == "ABC" {
                            Button(action: { toggleSymbolMode() }) {
                                Text(key)
                                    .font(.custom("Galmuri11-Bold", size: 18))
                                    .foregroundColor(inputMode == .symbol ? .green : .white)
                                    .frame(height: 45)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.clear)
                                    .overlay(
                                        Rectangle()
                                            .stroke(Color.green, lineWidth: 2)
                                    )
                            }
                        } else {
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
            }
            // 하단: 한/영, 스페이스(길게), 엔터만 배치
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
                // 엔터 버튼
                Button(action: { onKeyPress(" ↵ ") }) {
                    Text("↵")
                        .font(.custom("Galmuri11-Bold", size: 18))
                        .foregroundColor(.white)
                        .frame(width: 60, height: 45)
                        .background(Color.clear)
                        .overlay(Rectangle().stroke(Color.green, lineWidth: 2))
                }
            }
            .frame(height: 45)
        }
        .padding(.top, -20)
    }

    // 키패드 행별 배열
    private var keyRows: [[String]] {
        switch inputMode {
        case .korean:
            let isShifted = self.isShifted
            let row1 = isShifted ? ["ㅃ","ㅉ","ㄸ","ㄲ","ㅆ","ㅛ","ㅕ","ㅑ","ㅒ","ㅖ"] : ["ㅂ","ㅈ","ㄷ","ㄱ","ㅅ","ㅛ","ㅕ","ㅑ","ㅐ","ㅔ"]
            let row2 = ["ㅁ","ㄴ","ㅇ","ㄹ","ㅎ","ㅗ","ㅓ","ㅏ","ㅣ","←"]
            // 3번째 줄: ⇧, ㅋ, ㅌ, ㅊ, ㅍ, ㅠ, ㅜ, ㅡ, #?
            let row3 = ["⇧","ㅋ","ㅌ","ㅊ","ㅍ","ㅠ","ㅜ","ㅡ", (inputMode == .symbol ? "ABC" : "#?")]
            return [row1, row2, row3]
        case .english:
            let row1 = isShifted ? ["Q","W","E","R","T","Y","U","I","O","P"] : ["q","w","e","r","t","y","u","i","o","p"]
            let row2 = isShifted ? ["A","S","D","F","G","H","J","K","L","←"] : ["a","s","d","f","g","h","j","k","l","←"]
            // 3번째 줄: ⇧, z, x, c, v, b, n, m, #?
            let row3 = (isShifted ? ["⇧","Z","X","C","V","B","N","M", (inputMode == .symbol ? "ABC" : "#?")] : ["⇧","z","x","c","v","b","n","m", (inputMode == .symbol ? "ABC" : "#?")])
            return [row1, row2, row3]
        case .number:
            return [
                ["1","2","3","4","5","6","7","8","9","0"],
                ["-","/",":",";","(",")","$","&","@","\"","←"],
                // 3번째 줄: ., ,, ?, !, ', #?
                [".",",","?","!","'", (inputMode == .symbol ? "ABC" : "#?")]
            ]
        case .symbol:
            return [
                ["[","]","{","}","#","%","^","*","+","="],
                ["_","\\","|","~","<",">","€","£","¥","•","←"],
                // 3번째 줄: ., ,, ?, !, ', #?
                [".",",","?","!","'", (inputMode == .symbol ? "ABC" : "#?")]
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
        triggerHaptic()
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
        triggerHaptic()
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

    private func startBackspaceTimer() {
        backspaceTimer?.invalidate()
        backspaceTimer = Timer.scheduledTimer(withTimeInterval: 0.08, repeats: true) { _ in
            onBackspace()
        }
    }

    private func stopBackspaceTimer() {
        backspaceTimer?.invalidate()
        backspaceTimer = nil
    }

    private func isHangulJamo(_ key: String) -> Bool {
        let jamoSet = "ㄱㄲㄴㄷㄸㄹㅁㅂㅃㅅㅆㅇㅈㅉㅊㅋㅌㅍㅎㅏㅐㅑㅒㅓㅔㅕㅖㅗㅘㅙㅚㅛㅜㅝㅞㅟㅠㅡㅢㅣ"
        return jamoSet.contains(key)
    }

    private func triggerHaptic() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    private func startCursorBlink() {
        cursorTimer?.invalidate()
        cursorTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            showCursor.toggle()
        }
    }
    
    private func stopCursorBlink() {
        cursorTimer?.invalidate()
        cursorTimer = nil
    }
} 
