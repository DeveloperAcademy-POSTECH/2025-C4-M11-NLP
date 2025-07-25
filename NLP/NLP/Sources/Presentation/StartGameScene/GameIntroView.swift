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
        (nil, "", """
        키리듐이 처음 발견된 것은 화성 탐사선 레비아탄-3.

        귀환 당시 드릴 헤드 안쪽에 붙어 있던 고작 0.4그램의 분말.

        하지만 그 미량의 먼지가 가져온 파급력은 상상을 초월했다.

        국가와 민간, 모든 우주 기업들이 동시에 같은 생각을 품게 되었다.

        그리고 나는, 첫 공식 채굴 임무에 탑승하게 된 비행사이자 통신 엔지니어, 에어다.
        """),
        ("intro_3", "", """
        우주선에는 세 명이 탑승했다.
        핀, 조종과 수리 담당.
        말수는 적지만 늘 침착했다.

        전형적인 군 출신 같았지만, 가끔은 눈웃음이 귀여운 남자.

        그리고 제인.
        키리듐의 물리 구조 해석 전문가.

        정확히 말하면, 어마어마하게 예쁜 괴짜 과학자다.
        """),
        ("intro_4", "", """
        솔직히 말하자면, 처음 봤을 때 살짝 설렜다.
        
        하지만 그녀의 말투에는 늘 가시가 돋쳐있었고 지금껏 연애라는 걸 해본 적 있을까 싶을 만큼… 까칠했다.

        (나는 관심이 없다! 절대로!)
        """),
        ("intro_5", "", """
        목적지는 화성 너머의 협곡.

        우리는 비교적 소형 탐사선을 타고
        출발했기에 환승이 필요했다.

        하지만 그 전에 먼저 중간 기착지인
        오로라 정거장(Aurora Station)에서
        대형 채굴선으로 환승해야 했다.

        모든 절차는 순조로웠다.
        도킹 직전까지는.
        """),
        (nil, "", """
        [접근 속도: 정상]
        [각도: 안정적]
        [통신 신호: 클리어]

        그 순간, 오로라 정거장으로부터 메시지가 날아왔다. 
        「권한 오류. 도킹 거부. 즉시 회피 기동 실시.」

        “뭐?”
        핀의 목소리가 처음으로 흔들렸다.
        동시에 계기판이 붉게 깜박이기 시작한다.

        [궤도 이탈 경고!]
        [충돌 위험!]

        나는 순간, 누군가 우리를 밀어내고 있다는 느낌을 받았다.

        의도적인 간섭이다.
        무언가가 우릴 방해하고 있어.

        “안돼!!! 너무 위험해!!!!”
        """),
        ("intro_7", "", """
        곧이어 강렬한 충격.
        기체가 휘청이고 몸이 벽에 부딪혔다.

        “핀!”
        “제인!!!”

        산소 농도 경고음이 울리고,
        창밖의 별들이 일그러져 보였다.

        그게 내가 기억하는 마지막 장면이었다.
        의식은 어둠 속으로 가라앉았다.
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
                        .background(Color.white)
                        .padding(.bottom, 32)
                } else {
                    Spacer()
                    // 중앙 정렬을 위해 위에 Spacer 추가
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
                        .foregroundColor(pageIndex == 0 ? .gray : .white)
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
    }
} 
