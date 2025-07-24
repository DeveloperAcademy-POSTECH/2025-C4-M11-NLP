//
//  StageOneGameViewModel.swift
//  NLP
//
//  Created by 양시준 on 7/14/25.
//

import SwiftUI

@MainActor
class StageOneGameViewModel: ViewModelable {
    struct State {
        var isChatting: Bool = false
        var isDialogPresented: Bool = true
        var stageOnePhase: StageOneMonologuePhase = .stageArrived
        var isFlashlightFoundPresented: Bool = false
        var isPasswordViewPresented: Bool = false
        var isNoteFoundPresented: Bool = false
        var isArrivedAtCentralControlRoomDoor: Bool = false
        var isTransitioning: Bool = false // 암전 효과용 상태 추가
        var isFlashlightFound: Bool = false // 손전등 발견 여부
        var isExplorationStarted: Bool = false // 돌아다니기 시작 여부
        var isOxygenWarningShown: Bool = false // 산소 부족 경고 대화 표시 여부
    }
    
    enum Action {
        case showDialog
        case hideDialog
        case showFlashlightFoundPresented
        case hideFlashlightFoundPresented
        case showPasswordView
        case hidePasswordView
        case showNoteFoundPresented
        case hideNoteFoundPresented
        case arrivedAtCentralControlRoomDoor
        case startExploration
        case flashlightFound
        case oxygenWarningShown
    }
    
    @ObservedObject var coordinator: Coordinator
    
    @Published var state: State = State()
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
        case .showDialog:
            state.isDialogPresented = true
        case .hideDialog:
            state.isDialogPresented = false
        case .showFlashlightFoundPresented:
            state.isFlashlightFoundPresented = true
        case .hideFlashlightFoundPresented:
            state.isFlashlightFoundPresented = false
        case .showPasswordView:
            state.isPasswordViewPresented = true
        case .hidePasswordView:
            state.isPasswordViewPresented = false
        case .showNoteFoundPresented:
            state.isNoteFoundPresented = true
        case .hideNoteFoundPresented:
            state.isNoteFoundPresented = false
        case .arrivedAtCentralControlRoomDoor:
            state.isArrivedAtCentralControlRoomDoor = true
        case .startExploration:
            state.isExplorationStarted = true
        case .flashlightFound:
            state.isFlashlightFound = true
        case .oxygenWarningShown:
            state.isOxygenWarningShown = true
        }
    }


}
