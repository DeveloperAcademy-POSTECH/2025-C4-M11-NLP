//
//  ItemBackGround.swift
//  NLP
//
//  Created by 원주니 on 7/21/25.
//

import SwiftUI

struct ItemBackGround: View {
    @Binding var isPresented: Bool
    var showXButton: Bool = true

    var body: some View {
        VStack(alignment: .trailing, spacing: 16){
            if showXButton {
                XButton(isPresented: $isPresented)
            }
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
    struct ItemBackGroundPreview: View {
        @State private var isShowing = true
        var body: some View {
            ItemBackGround(isPresented: $isShowing, showXButton: true)
        }
    }
    return ItemBackGroundPreview()
}
