//
//  noteInfo.swift
//  NLP
//
//  Created by 차원준 on 7/17/25.
//
import SwiftUI

struct NoteInfoView: View {

//    @Binding var isPresented: Bool


var body: some View {
    VStack {
        Spacer().frame(height: 150)
        
        Rectangle()
            .fill(.black.opacity(0.9))
            .frame(width: ConstantScreenSize.screenWidth * 0.9, height: ConstantScreenSize.screenHeight * 0.3)
            .border(Color.yellow, width: 7)
            .overlay(
                Image("Note")
                    .resizable()
                    .scaledToFit( )
            )
        Spacer()
        Text("핀의 코딩 수첩\n")
            .font(NLPFont.gameItemName)
        
        Text("장비들을 관리하기 위한 \n명령어들이 담겨있는 코딩 수첨.\n\n잘 활용하면 오래된 컴퓨터에\n접근이 가능해진다.")
            .font(NLPFont.gameItemDescription)
        Spacer()

        }
    }
}


//
//#Preview{
//    noteInfo(isPresented: .constant(true))
//}
