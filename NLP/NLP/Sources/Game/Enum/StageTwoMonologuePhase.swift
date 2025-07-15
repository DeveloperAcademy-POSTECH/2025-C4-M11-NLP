//
//  StageTwoMonologuePhase.swift
//  NLP
//
//  Created by Ted on 7/15/25.
//

enum StageTwoMonologuePhase: MonologuePhase {
    
    
    case stageArrived//  = "드디어 중앙통제실이다. 산소도 , 조명도 ....."
    case meetBot//  = "재수없는 놈이랑 또 마주쳤군..."
    case firstBotDialogEnd
    
    var monologue: String {
        switch self {
        case .stageArrived:
            return "드디어 중앙통제실이다. 산소도, 조명 문제도 해결돼서 다행이야. 근데 핀이랑 제인은 도대체 어디 있는거야..."
        case .meetBot:
            return "재수없는 놈이랑 또 마주쳤군... 제인 장난감인데 도움이 될 지는 모르겠지만 한 번 대화를 해보자."
        case .firstBotDialogEnd:
            return ""
        }
    }
    
    var buttonTexts: [String] {
        switch self {
        default:
            return ["이전", "다음"]
        }
    }
    
    var previousPhase: Self? {
        switch self {
        case .stageArrived:
            return nil
        case .meetBot:
            return .stageArrived
        case .firstBotDialogEnd:
            return .meetBot
        }
    }
    
    var nextPhase: Self? {
        switch self {
        case .stageArrived:
            return .meetBot
        case .meetBot:
            return .firstBotDialogEnd
        case .firstBotDialogEnd:
            return nil
        }
    }
    
    var isNextButtonActionEnabled: Bool {
        switch self {
        case .meetBot:
            return true
        default:
            return false
        }
    }
}

