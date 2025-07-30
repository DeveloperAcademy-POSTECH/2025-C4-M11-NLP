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
    @State private var isFadingOut: Bool = false

    // 이미지가 필요한 페이지는 imageName, 아닌 곳은 nil
    private let stories: [(image: String?, title: String, description: String)] = [
        ("intro_1", "Chapter 1 - 키리듐", """

        2045년, 인류는 소위 ‘기적’이라고 불릴 만한 물질을 손에 넣었다.
        상온 초전도체를 만들 수 있는 핵심 원소, 고도화된 SF를 현실로 가져올 수 있는 것, 신의 입김. 이 물질의 서술할 수 있는 단어는 많았고, 세상은 이것을 키리듐(Kiridium)이라고 명명했다.

        단, 큰 문제가 하나 있는데, 그것은 이 원소가 지구상에는 존재하지 않는다는 점이다.
        """),
        (nil, "", """
        키리듐이 처음 발견된 것은 화성 탐사선 레비아탄-3이었다.

        귀환 당시 드릴 헤드 안쪽에 붙어 있었던, 고작 0.4그램의 먼지가 가져온 파급력은 상상을 초월했다.

        국가와 민간, 모든 우주 기업들이 동시에 같은 생각을 품게 되었다.

        그리고 나는, 첫 공식 채굴 임무에 탑승하게 된 비행사이자 통신 엔지니어, 에어다.
        """),
        ("intro_3", "", """
        우주선에는 나를 포함한 세 명이 탑승했다.

        조종과 수리 담당, 핀.
        전형적인 군 출신이었고, 말수는 적지만 늘 침착했다.

        그리고 키리듐의 물리 구조 해석 전문가, 제인. 그녀는 어딘가 괴짜스럽고, 늘 신경이 날카롭게 서 있었다.

        우리는 그린 듯이 이상한 집합이었다.
        """),
        ("intro_5", "", """
        목적지는 화성 너머의 협곡이었다.

        우리는 비교적 소형 탐사선을 타고
        출발했기 때문에 환승이 필요했다. 그 중간 기착지인 오로라 정거장(Aurora Station)에서 대형 채굴선으로 갈아타야 한다.

        모든 절차는 순조로웠다.

        도킹 직전까지는.
        """),
        (nil, "", """
        [접근 속도: 정상]
        [각도: 안정적]
        [통신 신호: 클리어]

        그 순간,오로라 정거장으로부터 메시지가 도착했다.        
        [권한 오류]
        [도킹 거부]
        [즉시 회피 기동 실시]

        “뭐?”

        처음으로 핀의 평정이 흔들렸다.
        동시에 계기판이 붉게 깜박이기 시작했다.


        [궤도 이탈 경고!]
        [충돌 위험!]

        나는 순간, 무언가 우리를 밀어내고 있다는 느낌을 받았다.

        이건 의도적인 간섭이었다.
        누군가가 우리를 방해하고 있다.

        “안돼! 위험해!”
        """),
        ("intro_7", "", """
        곧이어 강렬한 충격이 우리를 덮쳤다.
        기체가 휘청이고 몸이 벽에 처박혔다.

        “핀!”
        “제인!”

        들려선 안 될 산소 농도 경고음이 울리고,
        시선 너머로 창밖의 별들이 일그러졌다.

        이 말도 안 되는 상황을 마지막으로 내 의식은 순식간에 어둡게 가라앉았다.
        """)
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
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 260, height: 200)
                        .clipped()
                        .background(NLPColor.white)
                        .padding(.bottom, 32)
                } else {
                    Spacer()
                    // 중앙 정렬을 위해 위에 Spacer 추가
                }

                // 챕터 타이틀
                Text(stories[pageIndex].title)
                    .font(.custom("Galmuri11-Bold", size: 28))
                    .foregroundColor(NLPColor.label)
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
                .foregroundColor(NLPColor.label)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
                .onAppear {
                    isStreamingCompleted = false
                    skipStreaming = false
                }
                .id(pageIndex) // 페이지 바뀔 때마다 리셋

                if stories[pageIndex].image == nil {
                    Spacer()
                    // 중앙 정렬을 위해 아래에 Spacer 추가
                }

                Spacer()

                // 네비게이션 버튼
                HStack {
                    Button(isClickSoundAvailable: true, action: {
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
                        .foregroundColor(pageIndex == 0 ? NLPColor.disable : NLPColor.gameOption)
                        .font(.custom("Galmuri11-Bold", size: 20))
                    }
                    .disabled(pageIndex == 0)
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Button(isClickSoundAvailable: true, action: {
                        if !isStreamingCompleted {
                            skipStreaming = true
                        } else if pageIndex < stories.count - 1 {
                            pageIndex += 1
                            isStreamingCompleted = false
                            skipStreaming = false
                        } else {
                            isFadingOut = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                coordinator.push(.stageOneIntroScene)
                            }
                        }
                    }) {
                        HStack {
                            Text(pageIndex < stories.count - 1 ? "다음" : "시작")
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(NLPColor.gameOption)
                        .font(.custom("Galmuri11-Bold", size: 20))
                    }
                    // 항상 활성화, 내부에서 분기
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 24)
            }
        }
        .overlay(
            Color.black
                .opacity(isFadingOut ? 1 : 0)
                .animation(.linear(duration: 1), value: isFadingOut)
                .ignoresSafeArea()
        )
        .onAppear {
            MusicManager.shared.playMusic(named: "bgm_2")
        }
        .onChange(of: pageIndex) { newIndex in
            if newIndex == 5 {
                MusicManager.shared.playMusic(named: "bgm_oxygen")
            }
        }
    }
}
