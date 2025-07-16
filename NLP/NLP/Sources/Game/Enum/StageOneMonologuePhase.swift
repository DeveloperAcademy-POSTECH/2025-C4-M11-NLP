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
    
    // TODO: 비밀번호로 문 여는 것까지 구현 시 수정
    static let lastPhase: Self = .startFinding
    
    var monologue: String {
        switch self {
        case .stageArrived:
            return "너무 어두워. 뭐라도 찾아봐야겠어.\n\n돌아다녀 볼까?"
        case .findFlashlight:
            return "손전등을 찾았어! 주변이 좀 더 잘 보이는 군...\n\n이제 뭘 해야 하지?"
        case .goToCenteralControlRoom:
            return "아 맞다, 산소 발생기가 꺼진 것 같으니 이것부터 손봐야지. 중앙통제실로 가봐야겠어."
        case .lockedDoor:
            return "젠장! 중앙통제실 문이 잠겨있어... 핀이랑 제인은 도대체 어디에 있는거지?\n\n비밀번호는 내 생일이었는데..."
        case .wrongPassword:
            return "분명 비밀번호가 내 생일이었는데, 누군가 바꾼 것 같네... 핀, 제인... 날 버린거야? 아니면 누가 날 죽이려고...?"
        case .decreaseOxygen:
            return "크헉... 숨은 또 왜...\n산소가 거의 남지 않았구나.\n\n어떻게든 비밀번호를 찾아야 산소 발생기를 켤 수 있어..."
        case .startFinding:
            return "그래, 근처에 단서가 될만한 무언가가 있을거야.\n\n일단 주위를 둘러보자."
        }
    }
    
    var buttonTexts: [String] {
        switch self {
        case .startFinding:
            return ["이동하기"]
        case .goToCenteralControlRoom:
            return ["이전", "이동하기"]
        case .stageArrived, .findFlashlight, .lockedDoor, .wrongPassword, .decreaseOxygen:
            return ["다음"]
        default:
            return ["이전", "다음"]
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
