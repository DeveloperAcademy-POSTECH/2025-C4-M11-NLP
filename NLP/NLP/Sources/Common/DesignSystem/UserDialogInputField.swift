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
    @FocusState var isFocused: Bool // 사용하지 않음(커스텀 키보드)
    let submitAction: () -> Void
    
    var body: some View {
        CustomKeyboardView(text: $inputText, onCommit: submitAction)
    }
}

#Preview {
    @Previewable @State var inputText: String = ""
    @Previewable @State var showCursor: Bool = false
    UserDialogInputField(inputText: $inputText, showCursor: $showCursor, submitAction: {
        
    })
    .background(.black)
}
