//
//  OxygenWarningView.swift
//  NLP
//
//  Created by 차원준 on 7/22/25.
//

import SwiftUI

struct OxygenGaugeView: View {
    let oxygen: Int // 외부에서 산소값을 받음
    
    var body: some View {
        let gaugeWidth = ConstantScreenSize.screenWidth * 0.78
        let gaugeHeight = ConstantScreenSize.screenHeight * 0.03
        ZStack {
            ZStack(alignment: .leading) {
                Image("oxygenGauge")
                    .resizable()
                    .frame(width: gaugeWidth, height: gaugeHeight)
                Rectangle()
                    .frame(width: gaugeWidth * CGFloat(oxygen) / 100, height: gaugeHeight)
                    .foregroundColor(.green)
                    .animation(.linear(duration: 0.3), value: oxygen)
                    .padding(4)
            }
            Text("산소: \(oxygen)%")
                .font(.system(size: gaugeHeight * 0.7))
                .foregroundColor(.white)
        }
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        OxygenGaugeView()
    }
}
