//
//  StageFourMonologuePhase.swift
//  NLP
//
//  Created by Ted on 7/24/25.
//

enum StageFourMonologuePhase: MonologuePhase {
    case recognizeSignalFromFuture
    case signalFromFutureOne
    case caseCommCheckWithJane
    case jainMonologueOne
    case pinnMonologueOne
    case ponderAboutMethod
    case signalFromFutureTwo
    case pinnMonologueTwo
    case jainMonologueTwo
    case pinnMonologueThree
    case pinnMonologueFour
    
    // MARK: 엔딩 1
    case endingOnePartOne
    
    // MARK: 엔딩 2
    case endingTwoPartOne
    case endingTwoPartTwo
    case endingTwoPartThree
    case endingTwoPartFour
    case endingTwoPartFive
    case endingTwoPartSix
    case endingTwoPartSeven
    case endingTwoPartEight
    
    
    // TODO: 비밀번호로 문 여는 것까지 구현 시 수정
    static let lastPhase: Self = .endingTwoPartEight
    
    var monologue: String {
        switch self {
        case .recognizeSignalFromFuture:
            "핀: 지금 미래에서 또 신호가 온 것 같아. 중요한 것 같으니까 같이 확인해보자."
        case .signalFromFutureOne:
            "[SIGNAL ID] 43-FWD-RET\n[JANE] 지구가 멸망했다. 지금은 충돌 후 22시간 경과한 시간. 나의 미래는 이미 희망을 잃었다. 하지만 과거의 너희는 지구를 지킬 수 있을지도 모른다."
        case .caseCommCheckWithJane:
            "...우리가 가만히만 있으면 지구는 1시간 후 멸망하게 되겠군. 먼저 지구에 신호를 보내야 하는데.. 제인, 통신장비는 어떻게 됐어?"
        case .jainMonologueOne:
            "제인: 이미 JTO를 통해 지구에 실험하지 말라는 메시지를 보냈어. 하지만 당국은 실험을 강행할 생각인가봐. 우리 말을 들으려 하지 않아."
        case .pinnMonologueOne:
            "핀: 나도 과거로 TEST를 보내는 데에 성공한 것 같아. 아마도 우리가 전에 받았던 메시지겠지."
        case .ponderAboutMethod:
            "우리가 아무리 대단한 걸 만들었다고 해도...지구가 멸망한다면 의미가 없을 거야.\n\n방법을 찾아내야만 해."
        case .signalFromFutureTwo:
            "[SIGNAL ID] 43-FWD-RET\n[JANE] 긴급. 아마도 이게 마지막 메시지가 될 듯 하다. 키리던스 현상을 막는 방법을 발견했어. 지금 가지고 있는 키리듐을 최대 강도 플라즈마로 연소시키면, 우주의 모든 키리듐이 비활성화돼. 모든 키리듐은 연결되어 있어. 그렇기에 내가 신호를 과거로 보낼 수 있는거야. 미래에서는 실험을 통해... ... ...."
        case .pinnMonologueTwo:
            "핀: 하지만... 키리듐을 비활성화 한다면... 우리의 노벨상은..."
        case .jainMonologueTwo:
            "제인: 그게 중요해? 지구가 지금 멸망하게 생겼는데."
        case .pinnMonologueThree:
            "핀: 에어, 네가 지휘관이니까 결정해. 키리듐을 비활성화 할거야? 아니면... 우리가 새로운 인류를 재건하면 되지 않을까?"
        case .pinnMonologueFour:
            "핀: 키리듐을 비활성화 하면...지구에는 희망이 없어. 우리는 분명 큰 처벌을 받게 될거야."
        
        case .endingOnePartOne:
            "핀, 제인: 그래...이미 늦었지.우리는 키리듐의 활용을 극한으로 몰아붙여서, 다른 미래에서의 지구를 구하는거야."
            
        case .endingTwoPartOne:
            "핀, 제인: 잘 생각했어. 뒷일은 나중에 생각하자고!\n\n그런데...플라즈마 연소를 하려면..."
        case .endingTwoPartTwo:
            "JTO: 내가 할게. 너희는 생명이잖아. 나는 플라즈마에 연소돼도 아프지는 않잖아."
        case .endingTwoPartThree:
            "너가 우릴 위해 몇 번이나 희생을 했는데... 또 이렇게..."
        case .endingTwoPartFour:
            "JTO: 수많은 미래에서의 신호를 읽었어. 우리는 모두 영웅의 조각을 가지고 있어.\n\n꼭 지구를 지켜내야 한다."
        case .endingTwoPartFive:
            "...고마웠다 JTO.\n너를 절대로 잊지 않을거야.\n절대로."
        case .endingTwoPartSix:
            "그 재수없는 로봇 녀석이 그리워지는군.\n\n플라즈마실에서 완전히 가루가 됐겠지..."
        case .endingTwoPartSeven:
            "JTO: 웃기고 있네.\n\n공감 모드 실행해버린다?"
        case .endingTwoPartEight:
            "JTO!!! 죽지 않았구나!!!"
        }
    }
    
    var isSystemMonologue: Bool {
        switch self {
        case .signalFromFutureOne, .signalFromFutureTwo:
            return true
        default:
            return false
        }
    }
    
    var buttonTexts: [String] {
        switch self {
        case .pinnMonologueFour:
            return ["그래도 지구를 구해야 해.", "키리듐을 포기할 수는 없어."]
        default:
            return ["다음"]
        }
    }
    
    var previousPhase: Self? {
        switch self {
        case .recognizeSignalFromFuture:
            return nil
        case .signalFromFutureOne:
            return .recognizeSignalFromFuture
        case .caseCommCheckWithJane:
            return .signalFromFutureOne
        case .jainMonologueOne:
            return .caseCommCheckWithJane
        case .pinnMonologueOne:
            return .jainMonologueOne
        case .ponderAboutMethod:
            return .pinnMonologueOne
        case .signalFromFutureTwo:
            return .ponderAboutMethod
        case .pinnMonologueTwo:
            return .signalFromFutureTwo
        case .jainMonologueTwo:
            return .pinnMonologueTwo
        case .pinnMonologueThree:
            return .jainMonologueTwo
        case .pinnMonologueFour:
            return .pinnMonologueThree
            
        case .endingOnePartOne:
            return .pinnMonologueFour
            
        case .endingTwoPartOne:
            return .pinnMonologueFour
        case .endingTwoPartTwo:
            return .endingTwoPartOne
        case .endingTwoPartThree:
            return .endingTwoPartTwo
        case .endingTwoPartFour:
            return .endingTwoPartThree
        case .endingTwoPartFive:
            return .endingTwoPartFour
        case .endingTwoPartSix:
            return .endingTwoPartFive
        case .endingTwoPartSeven:
            return .endingTwoPartSix
        case .endingTwoPartEight:
            return .endingTwoPartSeven
        }
    }
    
    var nextPhase: Self? {
        switch self {
        case .recognizeSignalFromFuture:
            return .signalFromFutureOne
        case .signalFromFutureOne:
            return .caseCommCheckWithJane
        case .caseCommCheckWithJane:
            return .jainMonologueOne
        case .jainMonologueOne:
            return .pinnMonologueOne
        case .pinnMonologueOne:
            return .ponderAboutMethod
        case .ponderAboutMethod:
            return .signalFromFutureTwo
        case .signalFromFutureTwo:
            return .pinnMonologueTwo
        case .pinnMonologueTwo:
            return .jainMonologueTwo
        case .jainMonologueTwo:
            return .pinnMonologueThree
        case .pinnMonologueThree:
            return .pinnMonologueFour
        case .pinnMonologueFour:
            return nil
            
        case .endingOnePartOne:
            return nil
            
        case .endingTwoPartOne:
            return .endingTwoPartTwo
        case .endingTwoPartTwo:
            return .endingTwoPartThree
        case .endingTwoPartThree:
            return .endingTwoPartFour
        case .endingTwoPartFour:
            return .endingTwoPartFive
        case .endingTwoPartFive:
            return .endingTwoPartSix
        case .endingTwoPartSix:
            return .endingTwoPartSeven
        case .endingTwoPartSeven:
            return .endingTwoPartEight
        case .endingTwoPartEight:
            return nil
        }
    }
}
