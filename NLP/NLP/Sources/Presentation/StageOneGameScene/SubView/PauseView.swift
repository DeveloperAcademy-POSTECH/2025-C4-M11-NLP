//
//  PauseView.swift
//  SpriteKitExample
//
//  Created by 한건희 on 7/9/25.
//
import SwiftUI

struct PauseView: View {
    @Binding var isPaused: Bool
    var body: some View {
        GeometryReader { geo in
            Color.black.opacity(0.2)
                .frame(width: geo.size.width, height: geo.size.height)
                .overlay {
                    Text("Paused")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundStyle(NLPColor.label)
                        .background(NLPColor.disable)
                        .onTapGesture {
                            isPaused.toggle()
                        }
                }
        }
    }
}
