//
//  DialogManager.swift
//  SpriteKitExample
//
//  Created by 한건희 on 7/9/25.
//

import Combine
import FoundationModels
import SwiftUI

@MainActor
class DialogManager: ObservableObject {
    @Published var isGenerating = false
    @Published var currentPartner: DialogPartnerType?
    @Published var conversationLogs: [DialogPartnerType: [Dialog]] = [:]
    @Published var inputText: String = ""
    private var currentTask: Task<Void, Never>?
    private var conversations: [DialogPartnerType: LanguageModelSession] = [:]
    private var conversationTools: [DialogPartnerType: [any Tool]] = [:]
    // test 로직 추가
    @Published var isToolCalled: Bool = false
    
    private var toolSessions: [DialogPartnerType: LanguageModelSession] = [:]
    
    func initConversation(
        dialogPartner: DialogPartnerType,
        instructions: String,
        tools: [any Tool],
        initialMessage: String? = nil
    ) {
        initializeSession(
            dialogPartner: dialogPartner,
            instructions: instructions,
            tools: tools
        )
        currentPartner = dialogPartner
        conversationLogs[dialogPartner] = []
        
        // 초기 메시지가 있으면 설정, 없으면 기본값 사용
        if let initialMessage = initialMessage {
            conversationLogs[dialogPartner] = [
                Dialog(content: initialMessage, sender: .partner)
            ]
        } else if dialogPartner == .oxygen {
            conversationLogs[dialogPartner] = [
                Dialog(content: "산소 발생기는 위급한 상황에서만 사용 가능합니다.\n작동해야 하는 상황이나 사유를 말씀해주세요.", sender: .partner)
            ]
        } else if dialogPartner == .machine {
            conversationLogs[dialogPartner] = [
                Dialog(content: "조합된 코드를 입력하세요.", sender: .partner)
            ]
        }
    }
    
    func initializeSession(
        dialogPartner: DialogPartnerType,
        instructions: String,
        tools: [any Tool]?
    ) {
        // test로직
        // 기존 일반 세션 생성
        let generalSession = LanguageModelSession(
            model: .default,
            instructions: instructions
        )
        generalSession.prewarm()
        conversations[dialogPartner] = generalSession
        
        // 도구 호출용 세션 추가 생성
        guard let tools = tools else { return }
        
        conversationTools[dialogPartner] = tools
        
        let toolSession = LanguageModelSession(
            model: .default,
            tools: tools,
            instructions: ""
        )
        toolSession.prewarm()
        toolSessions[dialogPartner] = toolSession
    }
    
    func resetDialogLog(dialogPartner: DialogPartnerType? = nil) {
        if let dialogPartner = dialogPartner {
            conversationLogs[dialogPartner] = []
            return
        }
        guard let currentPartner = currentPartner else { return }
        conversationLogs[currentPartner] = []
    }
    
    func respond(
        _ userInput: String,
        dialogPartnerType: DialogPartnerType,
        isLogged: Bool
    ) {
        currentPartner = dialogPartnerType
        isGenerating = true
        
        if isLogged {
            let userDialog = Dialog(content: userInput, sender: .user)
            conversationLogs[dialogPartnerType]?.append(userDialog)
        }
        
        Task {
            do {
                // TDialogManager 로직 통합: 도구 호출 시도
                if let toolSession = toolSessions[dialogPartnerType] {
                    try await attemptToolCall(
                        userInput: userInput,
                        toolSession: toolSession,
                        dialogPartnerType: dialogPartnerType,
                        isLogged: isLogged
                    )
                    
                    // 도구가 호출된 경우 일반 응답 건너뛰기
                    if isToolCalled {
                        isToolCalled = false
                        isGenerating = false
                        return
                    }
                }
                
                // 일반 세션 응답
                await generateGeneralResponse(
                    userInput: userInput,
                    dialogPartnerType: dialogPartnerType,
                    isLogged: isLogged
                )
                
                isGenerating = false
                
            } catch {
                isGenerating = false
            }
        }
    }
    
    // 도구 호출 로직
    private func attemptToolCall(
        userInput: String,
        toolSession: LanguageModelSession,
        dialogPartnerType: DialogPartnerType,
        isLogged: Bool
    ) async throws {
        do {
            guard var toolSession = toolSessions[dialogPartnerType], let tools = conversationTools[dialogPartnerType], let toolInstruction = dialogPartnerType.toolInstruction else { return }
            toolSession = LanguageModelSession(model: .default, tools: tools, instructions: toolInstruction)
            try await toolSession.respond(
                to: userInput
            )
        } catch {
            print(error)
            throw error
        }
    }
    
    // 일반 응답 처리
    private func generateGeneralResponse(
        userInput: String,
        dialogPartnerType: DialogPartnerType,
        isLogged: Bool
    ) async {
        guard let session = conversations[dialogPartnerType] else { return }
        
        do {
            let response = try await session.respond(to: userInput)
            
            let partnerDialog = Dialog(content: response.content, sender: .partner)
            if isLogged {
                conversationLogs[dialogPartnerType]?.append(partnerDialog)
            }
        } catch {
            print("General response error: \(error)")
        }
    }
}
