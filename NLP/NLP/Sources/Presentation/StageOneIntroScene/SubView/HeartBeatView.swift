//
//  HeartBeatView.swift
//  NLP
//
//  Created by Ted on 7/14/25.
//

import SwiftUI

struct HeartBeatView: View {
    @State var offset: CGFloat = 0
    @State var isBeatWaiting: Bool = false
    
    var body: some View {
        ZStack {
            Color.black
            Image("heartBeat")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: ConstantScreenSize.screenWidth)
            Color.black
                .padding(.leading, offset)
        }
        .ignoresSafeArea()
        .frame(
            width: ConstantScreenSize.screenWidth,
            height: ConstantScreenSize.screenHeight
        )
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
                if isBeatWaiting { return }

                if offset >= ConstantScreenSize.screenWidth {
                    offset = 0
                    isBeatWaiting = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isBeatWaiting = false
                    }
                    return
                }

                offset += 10
            }
        }
    }
}
