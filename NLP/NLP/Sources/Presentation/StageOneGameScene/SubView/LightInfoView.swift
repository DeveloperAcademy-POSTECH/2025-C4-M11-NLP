//
// lightInfo.swift
//  NLP
//
//  Created by 차원준 on 7/17/25.
//

import SwiftUI

struct LightInfo: View {
    
    var body: some View {
        VStack {
            Spacer().frame(height: 150)
            
            Rectangle()
                .fill(.black.opacity(0.9))
                .frame(width: ConstantScreenSize.screenWidth * 0.9, height: ConstantScreenSize.screenHeight * 0.3)
                .border(Color.green, width: 7)
                .overlay(
                    Image("Flashlight")
                        .resizable()
                        .scaledToFit()
                )
            Spacer()
            Text("우주용 손전등\n")
                .font(NLPFont.body)
                .foregroundStyle(.white)

            Text("일반 손전등과 큰 차이는 없지만, \n흔들어서 발전이 가능하며\n충전이 따로 필요 없다.\n\n주위를 밝게 비춰준다.")
                .font(NLPFont.body)
                .foregroundStyle(.white)
            Spacer()

            }
        }
}
