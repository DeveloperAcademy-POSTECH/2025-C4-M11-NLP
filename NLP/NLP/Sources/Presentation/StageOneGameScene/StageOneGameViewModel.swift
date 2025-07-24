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
        var isOxygenDecreasingStarted: Bool = false // 산소 게이지 시작 여부
        var oxygenGuageValue: Int = 30 // 산소 양
        var isOxygenFound: Bool = false // 산소 발견 여부
        var isOxygenResolved: Bool = false // 산소 문제 해결 여부 (한 번 해결되면 다시 발생하지 않음)
        var isPasswordWarningShown: Bool = false // 비밀번호 오류 경고 대화 표시 여부
        var isOxygenChatting: Bool = false // 산소와의 채팅 여부
        var isMachineChatting: Bool = false // 기계와의 채팅 여부
        var isChatBotChatting: Bool = false // 챗봇과의 채팅 여부
        var isChatBotSettingPresented: Bool = false // 챗봇 세팅 UI 표시 여부
        var chatBotInstruction: String = "" // 챗봇 instruction
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

    @Published var state: State = .init()

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
