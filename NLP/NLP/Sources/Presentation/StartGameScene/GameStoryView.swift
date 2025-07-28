import SwiftUI

struct GameStoryView: View {
    let title: String
    let description: String
    @State private var isStreamingCompleted: Bool = false
    @State private var skipStreaming: Bool = false
    var onNext: (() -> Void)? = nil
    var body: some View {
        ZStack {
            Color(red: 36/255, green: 36/255, blue: 36/255).ignoresSafeArea()
            VStack(spacing: 0) {
                Spacer().frame(height: 60)
                // 타이틀
                Text(title)
                    .font(.custom("Galmuri11-Bold", size: 28))
                    .foregroundColor(NLPColor.label)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 24)
                // 본문 (StreamingText)
                StreamingText(
                    fullDialog: description,
                    streamingSpeed: 0.03,
                    skip: $skipStreaming,
                    streamingCompleted: { isStreamingCompleted = true }
                )
                .font(.custom("Galmuri11", size: 18))
                .foregroundColor(NLPColor.label)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
                .onAppear {
                    isStreamingCompleted = false
                    skipStreaming = false
                }
                Spacer()
                // 네비게이션 버튼
                Button(action: {
                    if !isStreamingCompleted {
                        skipStreaming = true
                    } else {
                        onNext?()
                    }
                }) {
                    HStack {
                        Text("다음")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(NLPColor.gameOption)
                    .font(.custom("Galmuri11-Bold", size: 20))
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 24)
            }
        }
    }
} 
