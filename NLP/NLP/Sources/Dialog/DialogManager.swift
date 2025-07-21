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
    var toolCalled: Bool = false
    private var currentTask: Task<Void, Never>?
    private var currentToolTask: Task<Void, Never>?
    private var conversationsWithTool: [DialogPartnerType: LanguageModelSession] = [:]
    private var conversations: [DialogPartnerType: LanguageModelSession] = [:]
    
    func initConversation(
        dialogPartner: DialogPartnerType,
        instructions: String,
        tools: [any Tool]
    ) {
        initializeSession(
            dialogPartner: dialogPartner,
            instructions: instructions,
            tools: tools
        )
        currentPartner = dialogPartner
        conversationLogs[dialogPartner] = []
    }
    
    func initializeSession(
        dialogPartner: DialogPartnerType,
        instructions: String,
        tools: [any Tool]
    ) {
        let newSession: LanguageModelSession = LanguageModelSession(
            model: .default,
            instructions: instructions
        )
        
        let newToolSession: LanguageModelSession = LanguageModelSession(
            model: .default,
            tools: tools,
        )
        newSession.prewarm()
        newToolSession.prewarm()
        conversations[dialogPartner] = newSession
        conversationsWithTool[dialogPartner] = newToolSession
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
        
        /// 유저 메시지 추가
        let userDialog = Dialog(content: userInput, sender: .user)
        if isLogged {
            conversationLogs[dialogPartnerType]?.append(userDialog)
        }

        currentTask = Task {
            do {
                let session = conversations[dialogPartnerType]
                
                guard let session = session else {
                    return
                }
                
                let toolSession = conversationsWithTool[dialogPartnerType]
                
                guard let toolSession = toolSession else {
                    return
                }

                let _ = try await toolSession.respond(to: "(반드시, 언어 응답보다 Tool Calling을 우선적으로 사용하세요.)" + userInput)
                
                if toolCalled {
                    toolCalled = false
                    return
                }
                
                let response = try await session.respond(to: userInput)
                
                let partnerDialog = Dialog(content: response.content, sender: .partner)
                
                if isLogged {
                    conversationLogs[dialogPartnerType]?.append(partnerDialog)
                }
                isGenerating = false
            } catch {
                isGenerating = false
            }
        }
    }
    
    func addLogs(dialogPartner: DialogPartnerType, dialog: String, sender: DialogSender, fromToolCalling: Bool = false) {
        conversationLogs[dialogPartner]?.append(Dialog(content: dialog, sender: sender, fromToolCalling: fromToolCalling))
    }
}
