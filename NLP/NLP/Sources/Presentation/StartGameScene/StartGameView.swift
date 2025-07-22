//
//  StartGameView.swift
//  NLP
//
//  Created by Ted on 7/14/25.
//

import SwiftUI

struct StartGameView: View {
    @StateObject var viewModel: StartGameViewModel
    
    init(coordinator: Coordinator) {
        self._viewModel = StateObject(wrappedValue: StartGameViewModel(coordinator: coordinator))
    }
    
    var body: some View {
        ZStack {
            // 배경 이미지
            Image("StartGameImage")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                // 타이틀 (Galmuri11-Bold 폰트 적용)
                Text("S i l e n c e")
                    .font(.custom("Galmuri11-Bold", size: 56))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.7), radius: 4, x: 2, y: 2)
                    .padding(.bottom, 180)
                Spacer()
                // 시작 버튼
                Button(action: {
                    viewModel.action(.startButtonTapped)
                }) {
                    Text("Start")
                        .font(.custom("Galmuri11-Bold", size: 24))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            Rectangle()
                                .stroke(Color.white, lineWidth: 4)
                                .background(Color.black.opacity(0.5).cornerRadius(6))
                        )
                }
                .padding(.horizontal, 80)
                .padding(.bottom, 16)
                // 테스트용 Stage 이동 버튼들 (가로 배치)
                HStack(spacing: 16) {
                    Button(action: {
                        viewModel.action(.goStage1)
                    }) {
                        Text("Stage 1")
                            .font(.custom("Galmuri11-Bold", size: 24))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                Rectangle()
                                    .stroke(Color.white, lineWidth: 4)
                                    .background(Color.black.opacity(0.5).cornerRadius(6))
                            )
                    }
                    Button(action: {
                        viewModel.action(.goStage2)
                    }) {
                        Text("Stage 2")
                            .font(.custom("Galmuri11-Bold", size: 24))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                Rectangle()
                                    .stroke(Color.white, lineWidth: 4)
                                    .background(Color.black.opacity(0.5).cornerRadius(6))
                            )
                    }
                    Button(action: {
                        viewModel.action(.goStage3)
                    }) {
                        Text("Stage 3")
                            .font(.custom("Galmuri11-Bold", size: 24))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                Rectangle()
                                    .stroke(Color.white, lineWidth: 4)
                                    .background(Color.black.opacity(0.5).cornerRadius(6))
                            )
                    }
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 60)
            }
        }
    }
}
