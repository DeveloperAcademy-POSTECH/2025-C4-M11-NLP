//
//  GameIntro.swift
//  NLP
//
//  Created by Gojaehyun on 7/22/25.
//

import SwiftUI

struct GameIntroView: View {
    @ObservedObject var coordinator: Coordinator
    @State private var pageIndex: Int = 0
    @State private var isStreamingCompleted: Bool = false
    @State private var skipStreaming: Bool = false
    
    // 이미지가 필요한 페이지는 imageName, 아닌 곳은 nil
    private let stories: [(image: String?, title: String, description: String)] = [
        ("intro_1", "Chapter 1 - 키리듐", """
        2045년, 인류는 스스로 신이라 착각하기에 충분한 기적의 원소를 손에 넣었다.
        이름은 키리듐(Kiridium).

        상온 초전도체를 만들 수 있는 핵심 원소.
        그야말로 현실화된 SF. 신의 입김.

        문제는 단 하나뿐이었다.
        이 원소는 지구에 존재하지 않는다는 것.
        """),
        (nil, "우주정거장의 비밀", "이 우주정거장은 단순한 연구기지가 아니다. 인류의 미래를 건 실험이 이곳에서 진행되고 있었다.\n\n키리듐의 힘을 이용해 시간과 공간을 조작하려는 시도, 그리고 그로 인한 예기치 못한 결과들..."),
        ("intro_3", "첫 번째 이상 신호", "충돌 이후, 정거장 내 모든 시스템이 불안정해졌다.\n\n산소, 전력, 통신... 모든 것이 끊겼다. 그리고 어딘가에서 들려오는 미약한 신호.\n\n누군가, 혹은 무언가가 살아있다."),
        ("intro_4", "기억의 파편들", "플레이어는 점점 자신의 기억이 조각나 있음을 깨닫는다.\n\n과거의 선택, 잃어버린 동료들, 그리고 반복되는 시간의 파편들...\n\n이곳에서 살아남으려면, 기억을 되찾아야 한다."),
        ("intro_5", "로봇의 등장", "정거장 어딘가에서 이상한 로봇이 나타난다.\n\n그는 플레이어에게 의미심장한 말을 남기고 사라진다.\n\n'선택의 순간이 곧 온다.'"),
        (nil, "중력의 왜곡", "정거장 내부의 중력이 이상하게 변한다.\n\n물체가 떠오르고, 시간이 느려지거나 빨라진다.\n\n플레이어는 이 현상을 이용해 탈출구를 찾아야 한다."),
        ("intro_7", "새로운 시작", "모든 진실을 마주한 플레이어.\n\n이제, 새로운 선택을 해야 할 시간이다.\n\n문이 열린다...")
    ]
    
    var body: some View {
        ZStack {
            Color(red: 36/255, green: 36/255, blue: 36/255).ignoresSafeArea()
            VStack(spacing: 0) {
                Spacer().frame(height: 60)

                // 이미지 또는 placeholder
                if let imageName = stories[pageIndex].image {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: 260, height: 200)
                        .background(Color.white)
                        .padding(.bottom, 32)
                } else {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(width: 260, height: 200)
                        .padding(.bottom, 32)
                }

                // 챕터 타이틀
                Text(stories[pageIndex].title)
                    .font(.custom("Galmuri11-Bold", size: 28))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 24)

                // 본문 (StreamingText)
                StreamingText(
                    fullDialog: stories[pageIndex].description,
                    streamingSpeed: 0.03,
                    skip: $skipStreaming,
                    streamingCompleted: { isStreamingCompleted = true }
                )
                .font(.custom("Galmuri11", size: 18))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
                .onAppear {
                    isStreamingCompleted = false
                    skipStreaming = false
                }
                .id(pageIndex) // 페이지 바뀔 때마다 리셋

                Spacer()

                // 네비게이션 버튼
                HStack {
                    Button(action: {
                        MusicManager.shared.playClickSound()
                        if pageIndex > 0 {
                            pageIndex -= 1
                            isStreamingCompleted = false
                            skipStreaming = true // 돌아간 페이지는 항상 완성된 텍스트
                        }
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("이전")
                        }
                        .foregroundColor(pageIndex == 0 ? .gray : .white)
                        .font(.custom("Galmuri11-Bold", size: 20))
                    }
                    .disabled(pageIndex == 0)
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Button(action: {
                        MusicManager.shared.playClickSound()
                        if !isStreamingCompleted {
                            skipStreaming = true
                        } else if pageIndex < stories.count - 1 {
                            pageIndex += 1
                            isStreamingCompleted = false
                            skipStreaming = false
                        } else {
                            coordinator.push(.stageOneIntroScene)
                        }
                    }) {
                        HStack {
                            Text(pageIndex < stories.count - 1 ? "다음" : "시작")
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(.white)
                        .font(.custom("Galmuri11-Bold", size: 20))
                    }
                    // 항상 활성화, 내부에서 분기
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 24)
            }
        }
        .onAppear {
            MusicManager.shared.playMusic(named: "bgm_2")
        }
        .onDisappear {
            MusicManager.shared.stopMusic()
        }
    }
} 
