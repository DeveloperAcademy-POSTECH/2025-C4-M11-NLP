//
//  StageTwoMonologuePhase.swift
//  NLP
//
//  Created by Ted on 7/15/25.
//

import SwiftUI

enum StageTwoMonologuePhase: MonologuePhase {
    
    case stageArrived
    case meetBot
    case botUselessThought
    case tryEmotionalApproach
//    case giveOrTalkChoice
    case unexpectedBotReaction
    case unexpectedAffectionMoment
    case botBehaviorShiftNoticed
    case jtoProblemModeInactive      // JTO 문제해결 모드 비활성 대사
    case jtoProblemModeSad           // JTO 슬픔 대사
    case journeyContinues            // 주인공 각오 대사
    
    static let lastPhase: Self = .journeyContinues
    
    var monologue: [(String, Color)] {
        switch self {
        case .stageArrived:
            return [("드디어 중앙통제실이다. 산소도, 조명 문제도 해결돼서 다행이야. 근데 핀이랑 제인은 도대체 어디 있는거야...", NLPColor.label)]
        case .meetBot:
            return [("재수없는 놈이랑 또 마주쳤군... 제인 장난감인데 도움이 될 지는 모르겠지만 한 번 대화를 해보자.", NLPColor.label)]
        case .botUselessThought:
            return [("하등 도움이 안된다. 제인이 공감모드였나 실험한다고 만든건데, 충돌때 맛이 간 것 같네...\n\n어떻게 해야 할까...", NLPColor.label)]
        case .tryEmotionalApproach:
            return [("공감밖에 하지 못하는 로봇이니까 감정을 건드려볼까? 아니면 뭔가 감동을 줄 만한게 있을까?", NLPColor.label)]
//        case .giveOrTalkChoice:
//            return "이건 아닌 것 같아. 줄 만한게 없는데...손전등이라도 줘볼까?"
        case .unexpectedBotReaction:
            return [("이러려고 준 건 아닌데...\n어? 어디 가는거야??", NLPColor.label)]
        case .unexpectedAffectionMoment:
            return [("이거 나한테 주려고 가져온건가?\n귀엽네...\n근데 이게 뭐지?", NLPColor.label)]
        case .botBehaviorShiftNoticed:
            return [("뭔가 표정이 바뀐 것 같기도 하고...", NLPColor.label)]
        case .jtoProblemModeInactive:
            return [("JTO: 저는 지금 문제해결 모드가 비활성화된 상태입니다. PDA 신호를 이용해 여기까지만 말씀드릴 수 .... 지지직", NLPColor.label)]
        case .jtoProblemModeSad:
            return [("JTO: 문제 해결 모드를 켜면 통신을 복구할... 저는 JTO 너무 슬퍼요. 슬퍼요. 슬퍼요. 슬퍼요. 슬퍼요. 슬퍼요. 슬퍼요. 슬퍼요. 슬퍼요. 슬퍼요. 슬퍼요.", NLPColor.label)]
        case .journeyContinues:
            return [("산 넘어 산이군... 그래. 주변에 뭔가가 있겠지!", NLPColor.label)]
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
//        case .giveOrTalkChoice:
//            return .tryEmotionalApproach
        case .unexpectedBotReaction:
            return .tryEmotionalApproach
        case .unexpectedAffectionMoment:
            return .unexpectedBotReaction
        case .botBehaviorShiftNoticed:
            return .unexpectedAffectionMoment
        case .jtoProblemModeInactive:
            return .botBehaviorShiftNoticed
        case .jtoProblemModeSad:
            return .jtoProblemModeInactive
        case .journeyContinues:
            return .jtoProblemModeSad
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
            return .unexpectedBotReaction
//        case .giveOrTalkChoice:
//            return .unexpectedBotReaction
        case .unexpectedBotReaction:
            return .unexpectedAffectionMoment
        case .unexpectedAffectionMoment:
            return .botBehaviorShiftNoticed
        case .botBehaviorShiftNoticed:
            return .jtoProblemModeInactive
        case .jtoProblemModeInactive:
            return .jtoProblemModeSad
        case .jtoProblemModeSad:
            return .journeyContinues
        case .journeyContinues:
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

