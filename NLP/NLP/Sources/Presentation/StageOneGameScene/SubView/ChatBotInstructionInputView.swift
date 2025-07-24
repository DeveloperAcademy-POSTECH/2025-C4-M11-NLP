import SwiftUI

struct ChatBotInstructionInputView: View {
    @Binding var isPresented: Bool
    @Binding var instruction: String
    var onConfirm: (() -> Void)? = nil

    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .foregroundStyle(Color.black.opacity(0.4))
                .ignoresSafeArea(.all)
            VStack {
                Spacer()
                Rectangle()
                    .foregroundStyle(Color.clear)
                    .frame(maxWidth: ConstantScreenSize.screenWidth * 0.9, maxHeight: ConstantScreenSize.screenHeight * 0.4)
                    .overlay(
                        ZStack(alignment: .topTrailing) {
                            VStack(spacing: 0) {
                                Text("챗봇 인스트럭션 입력")
                                    .font(.custom("Galmuri11-Bold", size: 22))
                                    .foregroundColor(.white)
                                    .padding(.top, 32)
                                Spacer()
                            }
                            XButton(isPresented: $isPresented)
                                .padding([.top, .trailing], 16)
                        }
                    )
                Spacer()
            }
            VStack(spacing: 0) {
                CustomKeyboardView(
                    text: $instruction,
                    onCommit: {}
                )
                Button("확인") {
                    isPresented = false
                    onConfirm?()
                }
                .font(.custom("Galmuri11-Bold", size: 18))
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(0)
            }
            .frame(maxWidth: .infinity)
            .background(Color.black.opacity(0.4))
        }
        .zIndex(200)
    }
} 