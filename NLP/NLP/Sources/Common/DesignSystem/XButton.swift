//
//  BackgroundView.swift
//  NLP
//
//  Created by Ted on 7/21/25.
//

import SwiftUI
import Foundation

struct XButton: View {
    @Binding var isPresented: Bool
    var body: some View {
        Button(isClickSoundAvailable: true) {
            isPresented = false
        } label: {
            Image("x-symbol")
                .resizable()
                .frame(width: 24, height:24)
        }
    }
}
