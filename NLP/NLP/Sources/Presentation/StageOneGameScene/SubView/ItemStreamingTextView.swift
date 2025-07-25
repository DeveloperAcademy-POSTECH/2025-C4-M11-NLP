import SwiftUI

struct ItemStreamingTextView: View {
    @Binding var isPresented: Bool
    let text: String
    let onClose: () -> Void
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    XButton(isPresented: $isPresented)
                        .padding([.top, .trailing], 16)
                }
                Spacer()
                Text(text)
                    .font(NLPFont.body)
                    .foregroundColor(.white)
                    .padding()
                Spacer()
                GameButton(buttonText: "다음") {
                    onClose()
                }
                .padding(.bottom, 40)
                .padding(.horizontal, 30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.8).ignoresSafeArea())
    }
} 