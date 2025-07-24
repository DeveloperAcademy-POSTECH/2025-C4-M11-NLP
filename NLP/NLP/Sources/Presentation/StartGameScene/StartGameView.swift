//
//  StartGameView.swift
//  NLP
//
//  Created by Ted on 7/14/25.
//

import SwiftUI

struct StartGameView: View {
    @StateObject var viewModel: StartGameViewModel
    @State private var showKeyboardTest: Bool = false
    @State private var keyboardTestText: String = ""
    
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
                    print("버튼 클릭! (Start)")
                    MusicManager.shared.playClickSound()
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
                        print("버튼 클릭! (Stage1)")
                        MusicManager.shared.playClickSound()
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
                        print("버튼 클릭! (Stage2)")
                        MusicManager.shared.playClickSound()
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
                        print("버튼 클릭! (Stage3)")
                        MusicManager.shared.playClickSound()
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
                .padding(.bottom, 16)
                // Keyboard Test 버튼
                Button(action: {
                    print("버튼 클릭! (Keyboard Test)")
                    MusicManager.shared.playClickSound()
                    withAnimation {
                        showKeyboardTest.toggle()
                    }
                }) {
                    Text("Keyboard Test")
                        .font(.custom("Galmuri11-Bold", size: 22))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(
                            Rectangle()
                                .stroke(Color.green, lineWidth: 3)
                                .background(Color.black.opacity(0.5).cornerRadius(6))
                        )
                }
                .padding(.horizontal, 80)
                .padding(.bottom, 60)
            }
            // 키보드 테스트 뷰 (화면 하단에 오버레이)
            if showKeyboardTest {
                VStack {
                    Spacer()
                    ZStack {
                        Color.black.opacity(0.7)
                            .ignoresSafeArea()
                        VStack(spacing: 0) {
                            HStack {
                                Text("Keyboard Test")
                                    .font(.custom("Galmuri11-Bold", size: 18))
                                    .foregroundColor(.white)
                                Spacer()
                                Button(action: { withAnimation { showKeyboardTest = false } }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 12)
                            .padding(.bottom, 4)
                            // 입력 결과 표시
                            Text(keyboardTestText)
                                .font(.custom("Galmuri11-Bold", size: 22))
                                .foregroundColor(.green)
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.black.opacity(0.5))
                                .cornerRadius(8)
                                .padding(.horizontal)
                            // 커스텀 키보드
                            CustomKeyboardView(text: $keyboardTestText)
                                .background(Color.black)
                        }
                        .padding(.bottom, 0)
                    }
                }
                .transition(.move(edge: .bottom))
            }
        }
        .onAppear {
            MusicManager.shared.playMusic(named: "bgm_1")
        }
    }
}
