//
//  SignalMachinePhase.swift
//  NLP
//
//  Created by 양시준 on 7/24/25.
//

import SwiftUI

enum SignalMachinePhase {
    
    case signal1
    case signal2
    case signal3
    case signal4
    case signalAgain
    
    var dialogText: [(String, Color)] {
        switch self {
        case .signal1:
            return [
                (
                    """
                    [SIGNAL ID] 18-FWD-RET 
                    [JANE] 아마도 플라즈마실에 있을거다. 나는 제인. 
                    [SIGNAL ID] 19-FWD-RET 
                    [JANE] 플라즈마실에 있을거다. 제인.
                    """,
                    NLPColor.green
                )
            ]
        case .signal2:
            return [
                (
                    """
                    [SIGNAL ID] 18-FWD-RET 
                    [JANE] 플라즈마실에 있을거다. 제인.
                    """,
                    NLPColor.green
                )
            ]
        case .signal3:
            return [
                ("제인 너 어디야\n\n", .white),
                (
                    """
                    회신할 수 없는 메시지. 송신자와 수신자의 시간이 다릅니다.
                    """,
                    NLPColor.green
                )
            ]
        case .signal4:
            return [
                ("제인 너 어디야\n\n", .white),
                (
                    """
                    회신할 수 없는 메시지. 송신자와 수신자의 시간이 다릅니다.
                    [SIGNAL ID] 20-FWD-RET 
                    [JANE] 플라즈마실에 있을거다. 제인
                    """,
                    NLPColor.green
                )
            ]
        case .signalAgain:
            return [
                (
                    """
                    [SIGNAL ID] 32-FWD-RET 
                    [FINN] TEST TEST 미래에서 보내는 신호다.
                    """,
                    NLPColor.green
                )
            ]
        }
    }
    
    static let lastPhase: Self = .signalAgain
    
    var nextPhase: Self? {
        switch self {
        case .signal1:
            return .signal2
        case .signal2:
            return .signal3
        case .signal3:
            return .signal4
        case .signal4:
            return .signalAgain
        case .signalAgain:
            return nil
        }
    }
}
