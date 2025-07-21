//
//  ItemBackGround.swift
//  NLP
//
//  Created by 원주니 on 7/21/25.
//

import SwiftUI

struct ItemBackGround: View {
@Binding var isPresented: Bool

var body: some View {
    VStack(alignment: .trailing, spacing: 16){
       XButton(isPresented: $isPresented)
        ZStack(alignment: .topLeading){
            Image("itemBackGround")
                .resizable()
                .frame(width: 320, height: 240)

                Text("ITEM INFO")
                .font(Font.custom("Galmuri11-Regular", size: 14))
                .foregroundStyle(Color.green)
                .padding(.leading, 11)
                
        }
        
    }
            
    }
}

#Preview {
    // 프리뷰에서 상호작용을 테스트하기 위해 @State 변수를 선언합니다.
    struct ItemBackGroundPreview: View {
        @State private var isShowing = true
        
        var body: some View {
            // isShowing 상태를 isPresented 바인딩에 연결합니다.
            ItemBackGround(isPresented: $isShowing)
        }
    }
    
    return ItemBackGroundPreview()
}
