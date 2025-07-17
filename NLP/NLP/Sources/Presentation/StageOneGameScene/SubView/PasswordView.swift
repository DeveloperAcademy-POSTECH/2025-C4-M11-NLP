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
    @State private var isDoorOpened = false
    
    @State private var buttonTappedTrigger: Bool = false
    @State private var passwordIncorrectTrigger: Double = 0
    
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
                .padding(.vertical, 32)
            }
        }
        .sensoryFeedback(.impact(weight: .light, intensity: 0.2), trigger: buttonTappedTrigger)
        .sensoryFeedback(.impact(weight: .medium, intensity: 1.0), trigger: passwordIncorrectTrigger)
    }
    
    private func handleTap(for label: String) {
        self.pressedButtonLabel = label
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
            } else {
                print("실패")
                handleFailure()
            }
        default:
            if inputText.count >= 4 { return }
            inputText += label
        }
    }
    
    private func handleFailure() {
        
        self.isPasswordIncorrect = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isPasswordIncorrect = false
            self.inputText = ""
        }
    }
}

#Preview {
    PasswordView()
}
