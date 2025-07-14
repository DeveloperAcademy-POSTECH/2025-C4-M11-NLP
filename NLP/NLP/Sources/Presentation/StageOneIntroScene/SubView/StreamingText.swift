//
//  StreamingText.swift
//  NLP
//
//  Created by Ted on 7/14/25.
//

import SwiftUI

struct StreamingText: View {
    var fullDialog: String
    var streamingSpeed: Double
    @State var currentText: String = ""
    @State var index: Int = 0
    @State var streamingCompleted: (() -> Void)?
    
    var body: some View {
        Text(String(currentText + "_"))
            .onAppear {
                Timer.scheduledTimer(
                    withTimeInterval: TimeInterval(floatLiteral: streamingSpeed),
                    repeats: true
                ) { timer in
                    let nextIndex = fullDialog.index(fullDialog.startIndex, offsetBy: index)
                    currentText += String(fullDialog[nextIndex])
                    
                    index += 1
                    
                    guard index < fullDialog.count else {
                        guard let dialogCompleted = streamingCompleted else { return }
                        dialogCompleted()
                        timer.invalidate()
                        return
                    }
                }
            }
    }
}
