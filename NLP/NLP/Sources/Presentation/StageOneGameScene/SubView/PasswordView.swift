//
//  PasswordView.swift
//  NLP
//
//  Created by 양시준 on 7/17/25.
//

import SwiftUI

struct PasswordView: View {
    @State private var inputText = ""
    @State private var pressedButtonLabel: String? = nil
    @State private var isPasswordIncorrect = false
    @State private var buttonTappedTrigger: Bool = false
    @State private var passwordIncorrectCount: Int = 0

    let backButtonTapAction: (() -> Void)?
    let successAction: (() -> Void)?
    let failureAction: (() -> Void)?
    @Binding var isDoorOpened: Bool

    private let correctPassword: String = "0720"
    
    let keypadLabels = [
        "1", "2", "3",
        "4", "5", "6",
        "7", "8", "9",
        "check", "0", "del"
    ]
    
    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 12), count: 3)
    
    var body: some View {
        ZStack {
            Image(isDoorOpened ? "door_opened" : "door_closed")
                .resizable()
                .scaledToFill()
                .animation(.spring(duration: 0.5), value: isDoorOpened)
                .ignoresSafeArea(.all)
            VStack(spacing: 0) {
                Spacer()
                PasswordFieldView(inputText: isDoorOpened ? "door opened" : inputText, isPasswordIncorrect: isPasswordIncorrect)
                    .padding(.horizontal, 22)
                Spacer()
                LazyVGrid(columns: columns, spacing: 6) {
                    ForEach(keypadLabels, id: \.self) { label in
                        let isPressed = self.pressedButtonLabel == label
                        PasswordButtonView(for: label, isPressed: isPressed)
                            .onTapGesture {
                                self.handleTap(for: label)
                                self.buttonTappedTrigger.toggle()
                            }
                    }
                }
                .padding(.horizontal, 46)
                HStack {
                    Button(action: {
                        backButtonTapAction?()
                    }) {
                        Text("< 이전")
                            .font(NLPFont.body)
                            .foregroundStyle(.white)
                    }
                    .padding(.vertical, 16)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(15)
                Spacer().frame(height: 35)
            }
//            Button(action: {
//                backButtonTapAction?()
//            }) {
//                // TODO: 추후 뒤로가기 버튼 이미지 변경 예정
//                Image("note")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 60)
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
//            .padding(.top, 42)
        }
        .sensoryFeedback(.impact(weight: .light, intensity: 0.2), trigger: buttonTappedTrigger)
        .sensoryFeedback(.impact(weight: .medium, intensity: 1.0), trigger: passwordIncorrectCount)
    }
    
    private func handleTap(for label: String) {
        self.pressedButtonLabel = label
        MusicManager.shared.playEffect(named: "button")
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        self.buttonTapped(label)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.pressedButtonLabel = nil
        }
    }

    private func buttonTapped(_ label: String) {
        switch label {
        case "del":
            if inputText.isEmpty { return }
            inputText.removeLast()
        case "check":
            if inputText == correctPassword {
                print("성공!")
                isDoorOpened = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    successAction?()
                }
            } else {
                print("실패")
                handleFailure()
                if passwordIncorrectCount >= 1 {
                    failureAction?()
                }
            }
        default:
            if inputText.count >= 4 { return }
            inputText += label
        }
    }
    
    private func handleFailure() {
        self.isPasswordIncorrect = true
        self.passwordIncorrectCount += 1
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isPasswordIncorrect = false
            self.inputText = ""
        }
    }
}
//
//#Preview {
//    PasswordView(
//        backButtonTapAction: { print("back button tapped") },
//        successAction: { print("success") },
//        failureAction: { print("failure") }
//    )
//}
