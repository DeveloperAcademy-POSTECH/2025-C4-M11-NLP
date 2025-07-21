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
            ItemBackGround(isPresented: $isPresented)
                .overlay(
                    Image(item.itemImageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                        .padding(.top, 20)
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

#Preview {
    // 1. 프리뷰에서 사용할 샘플 GameItem 데이터를 만듭니다.
    let sampleItem = GameItem(
        itemName: "코딩 수첩",
        itemDescription: "장비들을 관리하기 위한 명령어들이 담겨있는 코딩 수첩. 잘 활용하면 오래된 컴퓨터에 접근이 가능해진다.",
        itemImageName: "note" // Assets에 'note'라는 이름의 이미지가 있어야 합니다.
    )
    
    // 2. ItemCollectionView를 초기화합니다.
    return ItemCollectionView(
        isPresented: .constant(true), // isPresented 바인딩에 상수 값 제공
        item: sampleItem,             // 위에서 만든 샘플 아이템 전달
        backButtonTapAction: {
            // 뒤로가기 버튼 탭 액션 (프리뷰에서 확인용)
            print("Back button tapped!")
        },
        nextButtonTapAction: {
            // 다음 버튼 탭 액션 (프리뷰에서 확인용)
            print("Next button tapped!")
        }
    )
}
