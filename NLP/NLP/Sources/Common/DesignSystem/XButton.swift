//
//  BackgroundView.swift
//  NLP
//
//  Created by Ted on 7/21/25.
//

import SwiftUI

struct XButton: View {
    @Binding var isPresented: Bool
    var body: some View {
        Button {
            isPresented = false
        } label: {
            Image("x-symbol")
                .resizable()
                .frame(width: 24, height:24)
        }
    }
}
