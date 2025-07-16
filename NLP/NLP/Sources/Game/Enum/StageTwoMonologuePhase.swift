//
//  StageTwoMonologuePhase.swift
//  NLP
//
//  Created by Ted on 7/15/25.
//

enum StageTwoMonologuePhase: MonologuePhase {
    
    case stageArrived
    case meetBot
    case botUselessThought
    case tryEmotionalApproach
    case giveOrTalkChoice
    case unexpectedBotReaction
    case unexpectedAffectionMoment
    case botBehaviorShiftNoticed
    
    static let lastPhase: Self = .botBehaviorShiftNoticed
    
    var monologue: String {
        switch self {
        case .stageArrived:
            return "드디어 중앙통제실이다. 산소도, 조명 문제도 해결돼서 다행이야. 근데 핀이랑 제인은 도대체 어디 있는거야..."
        case .meetBot:
            return "재수없는 놈이랑 또 마주쳤군... 제인 장난감인데 도움이 될 지는 모르겠지만 한 번 대화를 해보자."
        case .botUselessThought:
            return "하등 도움이 안된다. 제인이 공감모드였나 실험한다고 만든건데, 충돌때 맛이 간 것 같네...\n\n어떻게 해야 할까..."
        case .tryEmotionalApproach:
            return "공감밖에 하지 못하는 로봇이니까 감정을 건드려볼까? 아니면 뭔가 감동을 줄 만한게 있을까?"
        case .giveOrTalkChoice:
            return "이건 아닌 것 같아. 줄 만한게 없는데...손전등이라도 줘볼까?"
        case .unexpectedBotReaction:
            return "이러려고 준 건 아닌데...\n어? 어디 가는거야??"
        case .unexpectedAffectionMoment:
            return "이거 나한테 주려고 부른건가?\n귀엽네...\n근데 이게 뭐지?"
        case .botBehaviorShiftNoticed:
            return "뭔가 표정이 바뀐 것 같기도 하고... 다시 말 걸어보면 되는건가??"
        }
    }
    
    var previousPhase: Self? {
        switch self {
        case .stageArrived:
            return nil
        case .meetBot:
            return .stageArrived
        case .botUselessThought:
            return .meetBot
        case .tryEmotionalApproach:
            return .botUselessThought
        case .giveOrTalkChoice:
            return .tryEmotionalApproach
        case .unexpectedBotReaction:
            return .giveOrTalkChoice
        case .unexpectedAffectionMoment:
            return .unexpectedBotReaction
        case .botBehaviorShiftNoticed:
            return .unexpectedAffectionMoment
        }
    }
    
    var nextPhase: Self? {
        switch self {
        case .stageArrived:
            return .meetBot
        case .meetBot:
            return .botUselessThought
        case .botUselessThought:
            return .tryEmotionalApproach
        case .tryEmotionalApproach:
            return .giveOrTalkChoice
        case .giveOrTalkChoice:
            return .unexpectedBotReaction
        case .unexpectedBotReaction:
            return .unexpectedAffectionMoment
        case .unexpectedAffectionMoment:
            return .botBehaviorShiftNoticed
        case .botBehaviorShiftNoticed:
            return nil
        }
    }
}

