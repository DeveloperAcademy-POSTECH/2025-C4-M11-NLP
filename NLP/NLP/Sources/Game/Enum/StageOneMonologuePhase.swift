//
//  StageOneMonologuePhase.swift
//  NLP
//
//  Created by 양시준 on 7/16/25.
//

import SwiftUI

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
    
    var monologue: [(String, Color)] {
        switch self {
        case .stageArrived:
            return [("너무 어두워. 뭐라도 찾아봐야겠어.\n\n돌아다녀 볼까?", NLPColor.label)]
        case .findFlashlight:
            return [("손전등을 찾았어! 주변이 좀 더 잘 보이는 군...\n\n이제 뭘 해야 하지?", NLPColor.label)]
        case .goToCenteralControlRoom:
            return [("아 맞다, 구조 신호를 보내려면 통신 시스템부터 손봐야지. 중앙통제실로 가봐야겠어.", NLPColor.label)]
        case .lockedDoor:
            return [("젠장! 중앙통제실 문이 잠겨있어. 핀이랑 제인은 도대체 어디에 있는거지? 비밀번호는 내 생일이었는데...", NLPColor.label)]
        case .wrongPassword:
            return [("분명 비밀번호는 내 생일이었는데, 누군가 바꾼 것 같다. 누가 바꾼걸까? 이걸 왜 바꾼거지?", NLPColor.label)]
        case .decreaseOxygen:
            return [("...숨쉬기가 버거워진다.산소가 거의 남지 않았다. 어떻게든 비밀번호를 찾아야 산소 발생기를 가동시킬 수 있는데.", NLPColor.label)]
        case .startFinding:
            return [("그래, 근처에 단서가 될만한 무언가가 있을거야.\n\n일단 주위를 둘러보자.", NLPColor.label)]
        case .findNote:
            return [("앗? 뭔가 있는데?. \n\n 수첩인가? 이거 핀이 쓰던 것 같은데... 열어보자.", NLPColor.label)]
        case .firstDialog:
            return [("핀이 쓰던 컴퓨터다! 조종실에서 종종 만지는 걸 봤어. \n\n 여기에 뭔가 힌트가 있지 않을까?", NLPColor.label)]
        case .afterFirstDialog:
            return [("이 컴퓨터는 도대체 어떻게 쓰는 거지? 아무것도 못 알아보겠어. 주변을 좀 더 찾아보자.", NLPColor.label)]
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

