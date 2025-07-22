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
        HStack {
            Text(inputText.isEmpty && showCursor ? "_" : inputText)
                .font(.custom("Galmuri11-Bold", size: 20))
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .padding(.horizontal, 12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.black)
        }
        .frame(height: 44)
    }
}

#Preview {
    @Previewable @State var inputText: String = ""
    @Previewable @State var showCursor: Bool = false
    UserDialogInputField(inputText: $inputText, showCursor: $showCursor, submitAction: {
        
    })
    .background(.black)
}
