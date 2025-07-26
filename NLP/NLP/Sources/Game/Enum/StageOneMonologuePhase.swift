//
//  StageOneMonologuePhase.swift
//  NLP
//
//  Created by 양시준 on 7/16/25.
//

enum StageOneMonologuePhase: MonologuePhase {
    
    case stageArrived
    case findFlashlight
    case goToCenteralControlRoom
    case lockedDoor
    case wrongPassword
    case decreaseOxygen
    case startFinding
    case findNote
    case firstDialog
    case afterFirstDialog
    
    static let lastPhase: Self = .findNote
    
    var monologue: String {
        switch self {
        case .stageArrived:
            return "너무 어두워. 뭐라도 찾아봐야겠어.\n\n돌아다녀 볼까?"
        case .findFlashlight:
            return "손전등을 찾았어! 주변이 좀 더 잘 보이는 군...\n\n이제 뭘 해야 하지?"
        case .goToCenteralControlRoom:
            return "아 맞다, 구조 신호를 보내려면 통신 시스템부터 손봐야지. 중앙통제실로 가봐야겠어."
        case .lockedDoor:
            return "중앙통제실에 들어가면 통신모드를 켤 수 있을거야. \n\n비밀번호는 내 생일이었어!\n문을 열어보자."
        case .wrongPassword:
            return "분명 비밀번호가 내 생일이었는데, 누군가 바꾼 것 같네... 핀, 제인... 날 버린거야? 아니면 누가 날 죽이려고...?"
        case .decreaseOxygen:
            return "크헉... 숨은 또 왜...\n산소가 거의 남지 않았구나.\n\n빨리 산소 발생기를 켜야해..."
        case .startFinding:
            return "그래, 근처에 단서가 될만한 무언가가 있을거야.\n\n일단 주위를 둘러보자."
        case .findNote:
            return "앗? 뭔가 여기 있는데?. \n\n 수첩인가? 이거 핀이 쓰던 것 같은데... 열어보자."
        case .firstDialog:
            return "핀이 쓰던 컴퓨터다! 조종실에서 종종 만지는 걸 봤어. \n\n 여기에 뭔가 힌트가 있지 않을까?"
        case .afterFirstDialog:
            return "이 컴퓨터는 도대체 어떻게 쓰는거야... 아무것도 못 알아듣네. ㅠ \n\n 주변을 좀 더 찾아보자."
        }
        
    }
    
    var isSystemMonologue: Bool {
        switch self {
        default:
            return false
        }
    }
    
    var buttonTexts: [String] {
        switch self {
        case .startFinding:
            return ["이동하기"]
        case .goToCenteralControlRoom:
            return ["이전", "이동하기"]
        case .stageArrived, .findFlashlight, .lockedDoor, .wrongPassword, .decreaseOxygen, .findNote, .firstDialog, .afterFirstDialog:
            return ["다음"]
        }
    }
    
    var previousPhase: Self? {
        switch self {
        case .stageArrived:
            return nil
        case .findFlashlight:
            return .stageArrived
        case .goToCenteralControlRoom:
            return .findFlashlight
        case .lockedDoor:
            return .goToCenteralControlRoom
        case .wrongPassword:
            return .lockedDoor
        case .decreaseOxygen:
            return .wrongPassword
        case .startFinding:
            return .decreaseOxygen
        case .findNote:
            return .afterFirstDialog
        case .firstDialog:
            return .startFinding
        case .afterFirstDialog:
            return .firstDialog
        }
    }
    
    var nextPhase: Self? {
        switch self {
        case .stageArrived:
            return .findFlashlight
        case .findFlashlight:
            return .goToCenteralControlRoom
        case .goToCenteralControlRoom:
            return .lockedDoor
        case .lockedDoor:
            return .wrongPassword
        case .wrongPassword:
            return .decreaseOxygen
        case .decreaseOxygen:
            return .startFinding
        case .startFinding:
            return .firstDialog
        case .firstDialog:
            return .afterFirstDialog
        case .afterFirstDialog:
            return .findNote
        case .findNote:
            return nil
        }
    }
    
    var isFirstButtonActionEnabled: Bool {
        switch self {
        default:
            return false
        }
    }
    
    var isSecondButtonActionEnabled: Bool {
        switch self {
        case .stageArrived, .goToCenteralControlRoom, .lockedDoor, .startFinding:
            return true
        default:
            return false
        }
    }
}

