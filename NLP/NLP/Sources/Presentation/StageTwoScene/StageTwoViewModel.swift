//
//  StageTwoViewModel.swift
//  NLP
//
//  Created by Ted on 7/15/25.
//

import SwiftUI

final class StageTwoViewModel: ViewModelable {
    struct State {
        var isDialogPresented: Bool = false
        var stageTwoPhase: Phase = .stageArrived
    }
    
    enum Action {
        
    }
    
    @Published var state: State = .init()
    @ObservedObject var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        
    }
    
    enum Phase: String {
        case stageArrived = "드디어 중앙통제실이다. 산소도 , 조명도 ....."
        case meetBot = "재수없는 놈이랑 또 마주쳤군..."
        case firstBotDialogEnd = ""
        
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
        
//        var
        
        
    }
}
