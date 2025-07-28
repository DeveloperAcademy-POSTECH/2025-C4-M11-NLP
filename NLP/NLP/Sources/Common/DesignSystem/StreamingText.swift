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
    var fullAttributedText: AttributedString
    
    var streamingSpeed: Double
    
    @Binding var skip: Bool
    @State var streamingEnd: Bool = false
    @State var timer: Timer?
    @State var currentText: AttributedString = ""
    @State var index: Int = 0
    var streamingCompleted: (() -> Void)?
    
    init(fullDialog: String, streamingSpeed: Double, skip: Binding<Bool>, streamingCompleted: (() -> Void)? = nil) {
        var fullDialog = AttributedString(fullDialog)
        fullDialog.foregroundColor = .white
        self.fullAttributedText = fullDialog
        self.streamingSpeed = streamingSpeed
        _skip = skip
        self.streamingCompleted = streamingCompleted
        initStreaming()
    }
    
    init(fullAttributedText: AttributedString, streamingSpeed: Double, skip: Binding<Bool>, streamingCompleted: (() -> Void)? = nil) {
        self.fullAttributedText = fullAttributedText
        self.streamingSpeed = streamingSpeed
        _skip = skip
        self.streamingCompleted = streamingCompleted
        initStreaming()
    }
    
    init(coloredText: [(String, Color)], streamingSpeed: Double, skip: Binding<Bool>, streamingCompleted: (() -> Void)? = nil) {
        self.fullAttributedText = ""
        for (text, color) in coloredText {
            let attrText = AttributedString(text, attributes: .init([.foregroundColor: UIColor(color)]))
            fullAttributedText.append(attrText)
        }
        self.streamingSpeed = streamingSpeed
        _skip = skip
        self.streamingCompleted = streamingCompleted
        initStreaming()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(currentText)
            // 커서 효과
            if !streamingEnd {
                Text("_")
                    .font(NLPFont.body)
                    .foregroundColor(.white)
            }
        }
        .font(NLPFont.body)
        .onAppear {
            startTimer()
        }
        .onChange(of: fullAttributedText) { _, _ in
            initStreaming()
            skip = false
            startTimer()
        }
        .onChange(of: skip) { _, newValue in
            if newValue {
                timer?.invalidate()
                currentText = fullAttributedText
                index = fullAttributedText.characters.count
                if !streamingEnd {
                    streamingCompleted?()
                    streamingEnd = true
                }
            } else {
                // skip이 false로 바뀌면(새로운 문장 등) 타이핑 재시작
                if currentText != fullAttributedText {
                    initStreaming()
                    startTimer()
                }
            }
        }
    }
    
    private func initStreaming() {
        timer?.invalidate()
        currentText = ""
        index = 0
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(
            withTimeInterval: TimeInterval(floatLiteral: streamingSpeed),
            repeats: true
        ) { timer in
            guard index < fullAttributedText.characters.count else {
                guard let dialogCompleted = streamingCompleted else {
                    skip = true
                    timer.invalidate()
                    return
                }
                dialogCompleted()
                streamingEnd = true
                skip = true
                timer.invalidate()
                return
            }
            
            typeNextCharacter()
            index += 1
        }
    }
    
    private func typeNextCharacter() {
        let characterIndex = fullAttributedText.characters.index(fullAttributedText.startIndex, offsetBy: index)
        let attributedCharacter = fullAttributedText[characterIndex...characterIndex]
        
        currentText.append(attributedCharacter)
    }
}

#Preview {
    StreamingText(
        coloredText: [
            ("제인 너 어디야\n\n", .white),
            ("회신할 수 없는 메시지. 송신자와 수신자의 시간이 다릅니다.", NLPColor.green)
        ],
        streamingSpeed: 0.03,
        skip: .constant(false)
    )
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(Color.gray)
}
