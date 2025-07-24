import SwiftUI

struct ChatBotInstructionInputView: View {
    @Binding var isPresented: Bool
    @Binding var instruction: String
    var onConfirm: (() -> Void)? = nil

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color.black.opacity(0.4))
                .ignoresSafeArea(.all)
            Rectangle()
                .foregroundStyle(Color.clear)
                .frame(maxWidth: ConstantScreenSize.screenWidth * 0.9, maxHeight: ConstantScreenSize.screenHeight * 0.8)
                .overlay(
                    GeometryReader { geometry in
                        ZStack(alignment: .topTrailing) {
                            VStack(spacing: 0) {
                                Text("챗봇 인스트럭션 입력")
                                    .font(.custom("Galmuri11-Bold", size: 22))
                                    .foregroundColor(.white)
                                    .padding(.top, 24)
                                Spacer()
                                CustomKeyboardView(
                                    text: $instruction,
                                    onCommit: {}
                                )
                                .padding(.bottom, 8)
                                Button("확인") {
                                    isPresented = false
                                    onConfirm?()
                                }
                                .font(.custom("Galmuri11-Bold", size: 18))
                                .padding(.vertical, 12)
                                .padding(.horizontal, 32)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .padding(.bottom, 24)
                            }
                            XButton(isPresented: $isPresented)
                                .padding([.top, .trailing], 16)
                        }
                    }
                )
        }
        .zIndex(200)
    }
} 