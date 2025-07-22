//
//  OxygenWarningView.swift
//  NLP
//
//  Created by 차원준 on 7/22/25.
//

import SwiftUI

struct OxygenGaugeView: View {
    let initialOxygen: Int
    var coordinator: Coordinator
    @State private var oxygen: Int = 0
    @State private var timer: Timer? = nil
    @State private var isBlackout: Bool = false
    
    var body: some View {
        let gaugeWidth = ConstantScreenSize.screenWidth * 0.78
        let gaugeHeight = ConstantScreenSize.screenHeight * 0.03
        ZStack {
            VStack {
                ZStack(alignment: .leading) {
                    Image("oxygenGauge")
                        .resizable()
                        .frame(width: gaugeWidth, height: gaugeHeight)
                    Rectangle()
                        .frame(width: gaugeWidth * CGFloat(oxygen) / 100, height: gaugeHeight)
                        .foregroundColor(.green)
                        .animation(.linear(duration: 0.3), value: oxygen)
                        .padding(4)
                    Text("산소: \(oxygen)%")
                        .font(.custom("Galmuri9", size: gaugeHeight * 0.7))
                        .foregroundColor(.white)
                }

            }
            if isBlackout {
                Color.black.opacity(0.9)
                    .ignoresSafeArea()
                    .transition(.opacity)
            }
        }
        .onAppear {
            oxygen = initialOxygen
            if timer == nil {
                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { t in
                    if oxygen > 0 {
                        oxygen -= 1
                    } else {
                        t.invalidate()
                        timer = nil
                        withAnimation {
                            isBlackout = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            coordinator.pop()
                            coordinator.push(.stageOneScene)
                        }
                    }
                }
            }
        }
        .onDisappear {
            timer?.invalidate()
            timer = nil
        }
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        OxygenGaugeView(initialOxygen: 30, coordinator: Coordinator())
    }
}
