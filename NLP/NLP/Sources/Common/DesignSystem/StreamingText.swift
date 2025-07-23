//
//  StreamingText.swift
//  NLP
//
//  Created by Ted on 7/14/25.
//

import SwiftUI

/**
 주어진 문자열을 한 글자씩 타이핑하는 효과를 보여주는 SwiftUI 뷰입니다.
 
 사용 예시:
 
 ```swift
 StreamingText(
     fullDialog: "안녕하세요, 한비입니다!",
     streamingSpeed: 0.05
 )
 ```
 - Parameters:
     - fullDialog: 화면에 타이핑 효과로 출력할 전체 문자열입니다.
     - streamingSpeed: 한 글자씩 출력되는 시간 간격(초 단위)입니다. 값이 작을수록 빠르게 출력됩니다.
     - streamingCompleted: 전체 문장이 모두 출력된 후 호출되는 선택적 클로저입니다.
 - Note: `StreamingText`는 `fullDialog`에 입력된 전체 문장을 지정한 속도에 따라 하나씩 출력합니다. 주로 게임 대사나 채팅 인터페이스에서 자연스러운 타이핑 효과를 주고 싶을 때 사용할 수 있습니다.
 - Note: 뷰가 화면에 나타나는 순간 자동으로 타이핑 효과가 시작됩니다.
*/
struct StreamingText: View {
    var fullDialog: String
    var streamingSpeed: Double
    @Binding var skip: Bool
    @State var timer: Timer?
    @State var currentText: String = ""
    @State var index: Int = 0
    @State var streamingCompleted: (() -> Void)?
    
    var body: some View {
        Text(String(currentText + "_"))
            .font(NLPFont.body)
            .onAppear {
                startTimer()
            }
            .onChange(of: fullDialog) { _, _ in
                timer?.invalidate()
                currentText = ""
                index = 0
                skip = false
                startTimer()
            }
            .onChange(of: skip) { _, newValue in
                if newValue {
                    timer?.invalidate()
                    currentText = fullDialog
                    index = fullDialog.count
                    streamingCompleted?()
                } else {
                    // skip이 false로 바뀌면(새로운 문장 등) 타이핑 재시작
                    if currentText != fullDialog {
                        timer?.invalidate()
                        currentText = ""
                        index = 0
                        startTimer()
                    }
                }
            }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(
            withTimeInterval: TimeInterval(floatLiteral: streamingSpeed),
            repeats: true
        ) { timer in
            let nextIndex = fullDialog.index(fullDialog.startIndex, offsetBy: index)
            currentText += String(fullDialog[nextIndex])
            index += 1
            guard index < fullDialog.count else {
                guard let dialogCompleted = streamingCompleted else {
                    timer.invalidate()
                    return
                }
                dialogCompleted()
                timer.invalidate()
                return
            }
        }
    }
}
