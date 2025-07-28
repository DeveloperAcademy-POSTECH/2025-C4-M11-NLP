//
//  GameLoadingView.swift
//  NLP
//
//  Created by Ted on 7/28/25.
//

import SwiftUI

struct GameLoadingView: View {
    
    @Binding var stageAllLoaded: Bool
    @State var progressRate: CGFloat = 0
    @State var isRateChanged: Bool = false
    @State var timer: Timer?
    
    init(stageAllLoaded: Binding<Bool>) {
        self._stageAllLoaded = stageAllLoaded
    }
    
    var body: some View {
        Color.black
            .ignoresSafeArea()
            .overlay(
                VStack {
                    Spacer()
                    Text("게임 로딩중 ... \n잠시 기다려주세요")
                        .multilineTextAlignment(.center)
                        .lineSpacing(10)
                        .foregroundStyle(.white)
                        .font(NLPFont.headline)
                        .padding(.bottom, 30)
                    RoundedRectangle(cornerRadius: 999)
                        .fill(NLPColor.background)
                        .frame(
                            width: ConstantScreenSize.screenWidth - 100,
                            height: 5
                        )
                        .overlay(
                            GeometryReader { proxy in
                                HStack {
                                    RoundedRectangle(cornerRadius: 999)
                                        .fill(.white)
                                        .frame(width: proxy.size.width * progressRate, height: proxy.size.height)
                                        .scaleEffect(x: isRateChanged ? 1.05 : 1, y: isRateChanged ? 1.7 : 1)
                                        .animation(.spring(duration: 0.2, bounce: 0.6), value: isRateChanged)
                                    Spacer()
                                }
                            }
                        )
                        .padding(.bottom, 40)
                    Spacer()
                }
            )
            .onChange(of: progressRate) { _, _ in
                isRateChanged.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    isRateChanged.toggle()
                }
            }
            .onAppear {
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] timer in
                    if stageAllLoaded {
                        withAnimation {
                            self.progressRate = 1
                        }
                        timer.invalidate()
                        return
                    }
                    
                    withAnimation {
                        self.progressRate += 0.1
                    }
                    
                    if progressRate >= 1 {
                        timer.invalidate()
                    }
                }
            }
    }
}
