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
            .opacity(0.1)
            .frame(width: ConstantScreenSize.screenWidth * 0.9, height: ConstantScreenSize.screenHeight * 0.45)
            .border(Color.yellow, width: 1)
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
