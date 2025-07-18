//
//  PasswordButtonView.swift
//  NLP
//
//  Created by 양시준 on 7/17/25.
//

import SwiftUI

struct PasswordButtonView: View {
    var label: String
    var isPressed: Bool = false
        
    init(for label: String, isPressed: Bool) {
        self.label = label
        self.isPressed = isPressed
    }
    
    var body: some View {
        keypadImage(for: label, isPressed: isPressed)
            .frame(maxHeight: .infinity, alignment: .bottom)
    }
}

@ViewBuilder
func keypadImage(for label: String, isPressed: Bool) -> some View {
    if isPressed {
        Image("number_button_pushed_\(label)")
            .resizable()
            .scaledToFit()
    } else {
        Image("number_button_\(label)")
            .resizable()
            .scaledToFit()
    }
}

#Preview {
    PasswordButtonView(for: "1", isPressed: false)
}
