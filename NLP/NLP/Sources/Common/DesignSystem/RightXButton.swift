//
//  RightXButton.swift
//  NLP
//
//  Created by Ted on 7/31/25.
//

import SwiftUI

struct RightXButton: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        HStack {
            Spacer()
            XButton(isPresented: $isPresented)
            Spacer().frame(width: 24)
        }
    }
}
