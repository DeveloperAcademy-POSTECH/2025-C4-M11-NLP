//
//  BackgroundView.swift
//  NLP
//
//  Created by Ted on 7/21/25.
//

import SwiftUI

struct DialogBackgroundView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
                  
        Rectangle()
            .fill(Color.black.opacity(0.5)) // 더 투명하게
            .frame(width: ConstantScreenSize.screenWidth * 0.9, height: ConstantScreenSize.screenHeight * 0.4)
            .border(Color.green, width: 2)
            .overlay {
                GeometryReader { geometry in
                    ZStack(alignment: .topTrailing) {
                        XButton(isPresented: $isPresented)
                            .padding([.top, .trailing], 16)

                        Image("dialogView-LT")
                            .resizable()
                            .frame(width: 20, height:20)
                            .position(x: 7, y: 7)
                        
                        Image("dialogView-RT")
                            .resizable()
                            .frame(width: 20, height:20)
                            .position(x: geometry.size.width - 7, y: 7)
                        
                        Image("dialogView-LD")
                            .resizable()
                            .frame(width: 20, height:20)
                            .position(x: 7, y: geometry.size.height - 7)
                        
                        Image("dialogView-RD")
                            .resizable()
                            .frame(width: 20, height:20)
                            .position(x: geometry.size.width - 7, y: geometry.size.height - 7)
                    }
                }
            }
    }
}
