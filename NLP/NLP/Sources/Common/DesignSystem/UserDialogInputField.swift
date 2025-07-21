//
//  UserDialogInputField.swift
//  NLP
//
//  Created by Ted on 7/21/25.
//

import SwiftUI

struct UserDialogInputField: View {
    @Binding var inputText: String
    @Binding var showCursor: Bool
    @FocusState var isFocused: Bool
    let submitAction: () -> Void
    
    var body: some View {
        ZStack(alignment: .leading) {
            if inputText.isEmpty && !isFocused {
                HStack(spacing: 0) {
                    // 깜빡이는 커서
                    if showCursor {
                        Text("_") // 또는 "|"
                            .foregroundColor(.gray)
                            .font(NLPFont.body)
                    }
                }
            }
//            TextEditor(text: $inputText)
//                .background(.black)
            
            TextField("", text: $inputText, axis: .vertical)
                .font(NLPFont.body)
                .foregroundStyle(.white)
                .focused($isFocused)
                .onChange(of: inputText) { _, newValue in
                    if newValue.last == "\n" {
                        inputText = String(newValue.dropLast())
                        if !inputText.isEmpty {
                            submitAction()
                            isFocused = false
                        }
                    }
                }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    @Previewable @State var inputText: String = ""
    @Previewable @State var showCursor: Bool = false
    UserDialogInputField(inputText: $inputText, showCursor: $showCursor, submitAction: {
        
    })
    .background(.black)
}
