//
//  OxygenWarningView.swift
//  NLP
//
//  Created by 차원준 on 7/22/25.
//

import SwiftUI

struct OxygenGaugeView: View {
    @Binding private var oxygen: Int
    var onOxygenDepleted: () -> Void

    init(initialOxygen: Binding<Int>, onOxygenDepleted: @escaping () -> Void) {
        self._oxygen = initialOxygen
        self.onOxygenDepleted = onOxygenDepleted
    }

    var body: some View {
        let gaugeWidth = ConstantScreenSize.screenWidth * 0.78
        let gaugeHeight = ConstantScreenSize.screenHeight * 0.03

        ZStack {
            ZStack(alignment: .leading) {
                Image("oxygenGauge")
                    .resizable()
                    .frame(width: gaugeWidth, height: gaugeHeight)
                Rectangle()
                    .frame(width: gaugeWidth * CGFloat(oxygen) / 100, height: gaugeHeight * 0.7)
                    .foregroundColor(NLPColor.primary)
                    .animation(.linear(duration: 0.3), value: oxygen)
                    .padding(4)
            }
            Text("산소: \(oxygen)%")
//                .font(.custom("Galmuri9", size: gaugeHeight * 0.7))
                .font(NLPFont.o2Gauge)
                .foregroundColor(NLPColor.label)
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { timer in
                if oxygen > 0 {
                    oxygen -= 1
                } else {
                    timer.invalidate()
                    onOxygenDepleted()
                }
            }
        }
    }
}

// #Preview {
//    ZStack {
//        Color.gray.ignoresSafeArea()
//        OxygenGaugeView(initialOxygen: 30) {
//            withAnimation(.linear(duration: 1)) {
//                viewModel.state.isTransitioning = true
//            }
//        }
//    }
// }
