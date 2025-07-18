//
//  ItemCollectionView.swift
//  NLP
//
//  Created by Ted on 7/15/25.
//

import SwiftUI

struct ItemCollectionView: View {
    @Binding var isPresented: Bool
    let item: GameItem
    
    let backButtonTapAction: (() -> Void)?
    let nextButtonTapAction: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Image("back")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60)
                    .onTapGesture {
                        backButtonTapAction?()
                    }
                Spacer()
            }
            Spacer()
            
            Rectangle()
                .fill(.black.opacity(0.5))
                .stroke(.yellow, lineWidth: 8)
                .frame(width: ConstantScreenSize.screenWidth - 40, height: 258)
                .overlay(
                    Image(item.itemImageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 120)
                )
                .padding(.bottom, 30)
            
            Text(item.itemName)
                .font(NLPFont.body)
                .foregroundStyle(.white)
                .padding(.bottom, 30)
            
            Text(item.itemDescription)
                .font(NLPFont.body)
                .foregroundStyle(.white)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 30)
            
            Spacer()
            
            GameButton(buttonText: "다음") {
                nextButtonTapAction?()
            }
            .padding(.bottom, 40)
            .padding(.horizontal, 30)
        }
        .background(.black.opacity(0.5))
    }
}

struct GameItem {
    var itemName: String
    var itemDescription: String
    var itemImageName: String
}
