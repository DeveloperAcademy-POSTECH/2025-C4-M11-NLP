//
//  StageThreeMonologuePhase.swift
//  NLP
//
//  Created by 양시준 on 7/22/25.
//

import SwiftUI

enum StageThreeMonologuePhase: MonologuePhase {
    
    case stageArrived
    case findFinn1
    case findFinn2
    case jtoDie1
    case jtoDie2
    case jtoDie3
    case airFinnTalk1
    case airFinnTalk2
    case airFinnTalk3
    case airFinnTalk4
    case airFinnTalk5_1
    case airFinnTalk5_2
    case airFinnTalk6
    case airFinnTalk7
    case receiveSign1
    case receiveSign2
    case receiveSign3
    case receiveSign4
    case receiveSign5
    case receiveSign6
    case receiveSign7
    case receiveSign8
    case receiveSign9
    case receiveSign10
    case lockedDoor1
    case lockedDoor2
    case lockedDoor3
    case lockedDoor4
    case lockedDoor5
    case lockedDoor6
    case lockedDoor7
    case explosion1
    case explosion2
    case explosion3
    case explosion4
    case explosion5
    case explosion6
    
    static let lastPhase: Self = .explosion6
    
    var monologue: [(String, Color)] {
        switch self {
        case .stageArrived:
            return [("""
            여기는 도킹베이... 기계장치에 문제가 생기지는 않았을지...
            """, NLPColor.label)]
        case .findFinn1:
            return [("""
            핀이 왜 여기에 있는 거야? 말도 안돼.
            핀, 괜찮아? 왜 여기에 혼자 쓰러져 있어?

            설마 뭐라도 해결해보려고 했나?
            """, NLPColor.label)]
        case .findFinn2:
            return [("""
            JTO: 잠깐. 뭔가 소리가 들립니다.

            조심하세요.
            """, NLPColor.label)]
        case .jtoDie1:
            return [("""
            JTO: L국의 사살 로-이에-. 제가 -압했으니 걱-마세-
            """, NLPColor.label)]
        case .jtoDie2:
            return [("""
            JTO: -
            """, NLPColor.label)]
        case .jtoDie3:
            return [("""
            JTO! 이런, 완전히 망가진건가?
            이제 막 정들 참이었는데...

            다행히 사살 로봇도 거의 망가진 것 같다.
            """, NLPColor.label)]
        case .airFinnTalk1:
            return [("""
            핀: 미안하다. 로봇을 피하려고 죽은 척 하고 있었어.
            """, NLPColor.label)]
        case .airFinnTalk2:
            return [("""
            핀, 네가 비밀번호 바꿨어?
            그것 때문에 무슨 일을 겪었는데, 정말 네가 그런 거야?            
            """, NLPColor.label)]
        case .airFinnTalk3:
            return [("""
            핀: 기억은 잘 안나지만, 아마 내가 바꾼 게 맞는 것 같아. 나 혼자라도 살고 싶어서...정말 미안해.
            """, NLPColor.label)]
        case .airFinnTalk4:
            return [("""
            난 널 정말 믿었어, 핀.
            """, NLPColor.label)]
        case .airFinnTalk5_1:
            return [("""
            핀: 정말 고마워. 우리가 꼭 귀환할 수 있도록 최선을 다 할게.            
            """, NLPColor.label)]
        case .airFinnTalk5_2:
            return [("""
            핀: 정말 미안해. 이제부터는 무슨 일이 있어도 실망시지키 않을게
            """, NLPColor.label)]
        case .airFinnTalk6:
            return [("""
            일단 신호를 수신해야 하니까 중앙통제실로 돌아가자.

            다른 이야기는 나중에 해도 늦지 않아.
            """, NLPColor.label)]
        case .airFinnTalk7:
            return [("""
            핀: JTO와 로봇 잔해는 내가 챙겼어. 내가 수리를 해볼게.

            에어: 그럼 내가 신호를 수신하고 있을게.
            """, NLPColor.label)]
        case .receiveSign1:
            return [("""
            대체 무슨 신호지? 제인과 우리의 시간이 다르다고? 시간여행이라도 한다는 건가.
            """, NLPColor.label)]
        case .receiveSign2:
            return [("""
            핀! 제인이 지금 플라즈마실에 있다는 신호가 왔어. 근데 미래에서 보내는 신호래. 대체 뭐라는 거야?
            """, NLPColor.label)]
        case .receiveSign3:
            return [("""
            핀: 어쩌면 정말로 미래에서 온 메시지일지도 몰라.
            """, NLPColor.label)]
        case .receiveSign4:
            return [("""
            그게 말이 돼? 미래에서 신호를 보낸다고? 그것도 제인이? 우리랑 같이 있었잖아?
            """, NLPColor.label)]
        case .receiveSign5:
            return [("""
            핀: 최근의 그 폭발, 보통 일이 아니야. 키리듐이랑 플라즈마가 반응하면서 기기들 시간이 전부 뒤틀렸을 거야.
            """, NLPColor.label)]
        case .receiveSign6:
            return [("""
            핀: 기억은 잘 나지 않지만, 아마도 그래서 비밀번호를 바꾸고 도망치려 했을 거야.
            """, NLPColor.label)]
        case .receiveSign7:
            return [("""
            신호가 하나 더 온다. 확인해 보자!
            """, NLPColor.label)]
        case .receiveSign8:
            return [("""
            핀, 너 지금 장난치는 거 아니지? 대체 이게 뭐야?
            """, NLPColor.label)]
        case .receiveSign9:
            return [("""
            핀: 아니. 네가 날 발견하지 않은 미래의 나는 저렇게 행동했을 거야. 우리와는 다른 미래에서 온 신호인 셈이지.
            시간이 없다. 빨리 가보자.
            """, NLPColor.label)]
        case .receiveSign10:
            return [("""
            그래. 무슨 말인지 아직 이해는 안 되지만, 제인을 만나러 가자.
            """, NLPColor.label)]
        case .lockedDoor1:
            return [("""
            젠장, 문이 또 잠겨있어. 심지어 열기 버튼도 작동을 안하는데?
            """, NLPColor.label)]
        case .lockedDoor2:
            return [("""
            JTO: 내가 분석해볼게.
            """, NLPColor.label)]
        case .lockedDoor3:
            return [("""
            ...? 이건 뭐야?
            """, NLPColor.label)]
        case .lockedDoor4:
            return [("""
            핀: 내가 고쳤어. 사살 로봇 부품을 써서 생긴 건 좀 그렇지만... JTO가 맞아.
            """, NLPColor.label)]
        case .lockedDoor5:
            return [("""
            JOT, 분석부탁해 
            
            생긴 게 정말 꺼림칙하다. JTO가 아니라 JOT이라고 불러야겠는데.
            """, NLPColor.label)]
        case .lockedDoor6:
            return [("""
            JTO: 공감 모드를 재실행합...

            아니야, 하지마!
            
            JTO: 재실행을 취소합니다.
            """, NLPColor.label)]
        case .lockedDoor7:
            return [("""
            JTO: 이 문은 대폭발을 대비한 문입니다. 플라즈마실에는 어떤 것이 숨겨져 있을 가능성이 큽니다. 잠시 몸을 숨기고 있으면, 제가 문을 열겠습니다.
            """, NLPColor.label)]
        case .explosion1:
            return [("""
            JTO 괜찮아???
            """, NLPColor.label)]
        case .explosion2:
            return [("""
            JTO: 응..충격이 크긴 하지만 사살용 로봇이 튼튼하긴 하네.
            이제 괜찮을거야.
            """, NLPColor.label)]
        case .explosion3:
            return [("""
            제인: 어떻게 알고 찾아왔지?
            """, NLPColor.label)]
        case .explosion4:
            return [("""
            그게 무슨 소리야? 너가 우리에게 신호를 보냈잖아! 
            """, NLPColor.label)]
        case .explosion5:
            return [("""
            제인: 아...내 이론이 정확히 맞았군.
            """, NLPColor.label)]
        case .explosion6:
            return [("""
            제인: 나는 폭발 이후에 우연히 이곳에 들어왔어. 문이 갑자기 닫혀버려서 안에 갇혀있었고.

            안으로 들어가서 설명해줄게.
            """, NLPColor.label)]
        }
    }
    
    var previousPhase: Self? {
        switch self {
        case .stageArrived:
            return nil
        case .findFinn1:
            return .stageArrived
        case .findFinn2:
            return .findFinn1
        case .jtoDie1:
            return .findFinn2
        case .jtoDie2:
            return .jtoDie1
        case .jtoDie3:
            return .jtoDie2
        case .airFinnTalk1:
            return .jtoDie3
        case .airFinnTalk2:
            return .airFinnTalk1
        case .airFinnTalk3:
            return .airFinnTalk2
        case .airFinnTalk4:
            return .airFinnTalk3
        case .airFinnTalk5_1:
            return .airFinnTalk4
        case .airFinnTalk5_2:
            return .airFinnTalk4
        case .airFinnTalk6:
            return .airFinnTalk5_1
        case .airFinnTalk7:
            return .airFinnTalk6
        case .receiveSign1:
            return .airFinnTalk7
        case .receiveSign2:
            return .receiveSign1
        case .receiveSign3:
            return .receiveSign2
        case .receiveSign4:
            return .receiveSign3
        case .receiveSign5:
            return .receiveSign4
        case .receiveSign6:
            return .receiveSign5
        case .receiveSign7:
            return .receiveSign6
        case .receiveSign8:
            return .receiveSign7
        case .receiveSign9:
            return .receiveSign8
        case .receiveSign10:
            return .receiveSign9
        case .lockedDoor1:
            return .receiveSign10
        case .lockedDoor2:
            return .lockedDoor1
        case .lockedDoor3:
            return .lockedDoor2
        case .lockedDoor4:
            return .lockedDoor3
        case .lockedDoor5:
            return .lockedDoor4
        case .lockedDoor6:
            return .lockedDoor5
        case .lockedDoor7:
            return .lockedDoor6
        case .explosion1:
            return .lockedDoor7
        case .explosion2:
            return .explosion1
        case .explosion3:
            return .explosion2
        case .explosion4:
            return .explosion3
        case .explosion5:
            return .explosion4
        case .explosion6:
            return .explosion5
        }
    }
    
    var nextPhase: Self? {
        switch self {
        case .stageArrived:
            return .findFinn1
        case .findFinn1:
            return .findFinn2
        case .findFinn2:
            return .jtoDie1
        case .jtoDie1:
            return .jtoDie2
        case .jtoDie2:
            return .jtoDie3
        case .jtoDie3:
            return .airFinnTalk1
        case .airFinnTalk1:
            return .airFinnTalk2
        case .airFinnTalk2:
            return .airFinnTalk3
        case .airFinnTalk3:
            return .airFinnTalk4
        case .airFinnTalk4:
            return .airFinnTalk5_1
        case .airFinnTalk5_1:
            return .airFinnTalk6
        case .airFinnTalk5_2:
            return .airFinnTalk6
        case .airFinnTalk6:
            return .airFinnTalk7
        case .airFinnTalk7:
            return .receiveSign1
        case .receiveSign1:
            return .receiveSign2
        case .receiveSign2:
            return .receiveSign3
        case .receiveSign3:
            return .receiveSign4
        case .receiveSign4:
            return .receiveSign5
        case .receiveSign5:
            return .receiveSign6
        case .receiveSign6:
            return .receiveSign7
        case .receiveSign7:
            return .receiveSign8
        case .receiveSign8:
            return .receiveSign9
        case .receiveSign9:
            return .receiveSign10
        case .receiveSign10:
            return .lockedDoor1
        case .lockedDoor1:
            return .lockedDoor2
        case .lockedDoor2:
            return .lockedDoor3
        case .lockedDoor3:
            return .lockedDoor4
        case .lockedDoor4:
            return .lockedDoor5
        case .lockedDoor5:
            return .lockedDoor6
        case .lockedDoor6:
            return .lockedDoor7
        case .lockedDoor7:
            return .explosion1
        case .explosion1:
            return .explosion2
        case .explosion2:
            return .explosion3
        case .explosion3:
            return .explosion4
        case .explosion4:
            return .explosion5
        case .explosion5:
            return .explosion6
        case .explosion6:
            return nil
        }
    }
    
    var isSystemMonologue: Bool {
        switch self {
        default:
            return false
        }
    }
}
