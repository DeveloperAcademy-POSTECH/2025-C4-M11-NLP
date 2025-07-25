//
//  StageThreeMonologuePhase.swift
//  NLP
//
//  Created by 양시준 on 7/22/25.
//

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
    
    var monologue: String {
        switch self {
        case .stageArrived:
            return """
            여기는 도킹베이... 기계장치에 문제가 생기지는 않았을지...
            """
        case .findFinn1:
            return """
            핀이 여기에 있다니...말도 안돼... 야, 너 괜찮아?? 왜 여기 혼자 쓰러져 있는거야...

            설마 뭐라도 해결해보려고...?
            """
        case .findFinn2:
            return """
            JTO: 잠깐...뭔가 소리가 들리는데...

            조심하세요!
            """
        case .jtoDie1:
            return """
            JTO: L국의 사살 로봇이에요. 제가 제압했으니 걱정마세...
            """
        case .jtoDie2:
            return """
            JTO: "공감할 수 있어서 즐거웠어...요"
            """
        case .jtoDie3:
            return """
            JTO!!! 정신 차려!! 아아악!!
            이제 정에 들 참이었는데...
            내가 꼭 복수해줄게.
            다행히 적국 로봇은 거의 망가진 것 같다.
            """
        case .airFinnTalk1:
            return """
            핀: 미안하다. 로봇을 피하려고 죽은 척 하고 있었어.
            """
        case .airFinnTalk2:
            return """
            너가 비밀번호 바꾼거 맞아? 그것때문에 죽을 뻔 했는데, 너가 정말 그런거야?
            """
        case .airFinnTalk3:
            return """
            핀: 기억이 잘... 나질 않아. 하지만 내가 맞는 것 같아. 나 혼자라도 살고 싶어서...

            정말 미안하다...
            """
        case .airFinnTalk4:
            return """
            널 정말 믿었는데...
            """
        case .airFinnTalk5_1:
            return """
            핀: 흑...고마워. 우리 꼭 귀환할 수 있도록 최선을 다해보자.
            """
        case .airFinnTalk5_2:
            return """
            핀: 정말 미안해...지금부터 최선을 다해볼게.
            """
        case .airFinnTalk6:
            return """
            일단 신호를 수신해야 하니까 중앙통제실로 돌아가자.

            다른 이야기는 나중에 해도 늦지 않아.
            """
        case .airFinnTalk7:
            return """
            핀: JTO와 로봇 잔해는 내가 챙겼어. 내가 수리를 해볼게.

            에어: 그럼 내가 신호를 수신하고 있을게.
            """
        case .receiveSign1:
            return """
            이게 무슨 신호지...제인과 내 시간이 다르다고? 시간여행이라도 한다는 건가...
            """
        case .receiveSign2:
            return """
            핀! 제인이 지금 플라즈마실에 있다는 신호가 왔어. 근데 좀 이상한게, 시간이 뒤죽박죽이야.
            """
        case .receiveSign3:
            return """
            핀: 어쩌면...미래에서 온 메시지일지도 몰라.
            """
        case .receiveSign4:
            return """
            그게 말이 돼? 미래에서 신호를 보낸다고? 그것도 제인이?
            """
        case .receiveSign5:
            return """
            핀: 응. 최근에 있었던 폭발, 보통 일이 아니야. 키리듐이랑 플라즈마가 반응하면서 기기들 시간이 전부 뒤틀렸었어.
            """
        case .receiveSign6:
            return """
            핀: 정확히 기억은 안나지만... 그래서 비밀번호를 바꾸고 도망치려 했던 것 같다.
            """
        case .receiveSign7:
            return """
            어...신호가 하나 더 온다. 확인해보자!
            """
        case .receiveSign8:
            return """
            핀...너 지금 장난하는거 아니지? 이게 뭐야...?
            """
        case .receiveSign9:
            return """
            핀: 아니. 너가 날 구하지 않았다면 나는 저렇게 행동했을거야. 우리와는 다른 미래에서 온 신호인 셈이지.
            시간이 없다. 빨리 가보자.
            """
        case .receiveSign10:
            return """
            그래. 이해는 되지 않아도, 제인을 구하러 가보자!
            """
        case .lockedDoor1:
            return """
            젠장, 문이 또 잠겨있어. 심지어 열기 버튼도 작동을 안하는데...?
            """
        case .lockedDoor2:
            return """
            JTO: 내가 분석해볼게.
            """
        case .lockedDoor3:
            return """
            ??? 너 누구야?
            """
        case .lockedDoor4:
            return """
            핀: 내가 고쳤어. 사살용 로봇 부품을 써서 비주얼은 좀 그렇지만... JTO가 맞아.
            """
        case .lockedDoor5:
            return """
            생긴건 정말 재수가 없군. JTO가 아니라 JOT이라 불러야겠어.

            분석 부탁해, JOT!
            """
        case .lockedDoor6:
            return """
            JTO: 공감 모드를 재실행합...

            미안!!! 농담이었어!!!

            JTO: 나도 농담이었어.
            """
        case .lockedDoor7:
            return """
            JTO: 이 문은 대폭발을 방지하게 위해 존재해. 플라즈마실에는 뭔가 숨겨진 비밀이 있는 듯 하다. 잠시 몸을 숨기고 있으면 내가 문을 열어볼게.
            """
        case .explosion1:
            return """
            JTO 괜찮아???
            """
        case .explosion2:
            return """
            JTO: 응..충격이 크긴 하지만 사살용 로봇이 튼튼하긴 하네.
            이제 괜찮을거야.
            """
        case .explosion3:
            return """
            제인: 어떻게 알고 찾아왔지?
            """
        case .explosion4:
            return """
            그게 무슨 소리야? 너가 우리에게 신호를 보냈잖아! 
            """
        case .explosion5:
            return """
            제인: 아...내 이론이 정확히 맞았군.
            """
        case .explosion6:
            return """
            제인: 나는 폭발 이후에 우연히 이곳에 들어왔어. 문이 갑자기 닫혀버려서 안에 갇혀있었고.

            안으로 들어가서 설명해줄게.
            """
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
}
