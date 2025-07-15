//
//  StageTwoViewModel.swift
//  NLP
//
//  Created by Ted on 7/15/25.
//

import SwiftUI

final class StageTwoViewModel: ViewModelable {
    struct State {
        var isMonologuePresented: Bool = false
        var isItemCollecting: Bool = false
        var isDialogPresented: Bool = false
        var stageTwoPhase: StageTwoMonologuePhase = .stageArrived
    }
    
    enum Action {
        case robotEncountered
    }
    
    @Published var state: State = .init()
    @ObservedObject var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
        case .robotEncountered:
            state.isMonologuePresented = true
        }
    }
}
