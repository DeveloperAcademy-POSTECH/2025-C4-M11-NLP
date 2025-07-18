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
    private var currentTask: Task<Void, Never>?
    private var conversations: [DialogPartnerType: LanguageModelSession] = [:]
    
    func initConversation(dialogPartner: DialogPartnerType) {
        let newSession: LanguageModelSession = LanguageModelSession(
            model: .default,
            tools: [
                UnlockTool(rightPasswordAction: { [weak self] in
                    // MARK: computer instruction 변경(암호를 맞춘 후, 컴퓨터가 어떠한 응답을 내뱉어줄지에 대한 instruction으로) 및 세션 초기화
                    self?.changeSession(
                        dialogPartner: dialogPartner,
                        instruction: dialogPartner.instructions,
                        tools: [] // TODO: 미결정
                    )
                })
            ],
            instructions: dialogPartner.instructions
        )
        
        newSession.prewarm()
        conversations[dialogPartner] = newSession
        currentPartner = dialogPartner
        conversationLogs[dialogPartner] = []
    }
    
    func initializeDialogLog(dialogPartner: DialogPartnerType) {
        conversationLogs[dialogPartner] = []
    }
    
    func changeSession(
        dialogPartner: DialogPartnerType,
        instruction: String,
        tools: [any Tool]
    ) {
        let newSession: LanguageModelSession = LanguageModelSession(
            model: .default,
            tools: tools,
            instructions: instruction
        )
        newSession.prewarm()
        
        conversations[dialogPartner] = newSession
        currentPartner = dialogPartner
        
        if conversationLogs[dialogPartner] == nil {
            conversationLogs[dialogPartner] = []
        }
    }
    
    func respond(
        _ userInput: String,
        dialogPartnerType: DialogPartnerType,
        isLogged: Bool
    ) {
        isGenerating = true
        if isLogged {
            conversationLogs[dialogPartnerType]?.append(Dialog(
                    content: userInput,
                    sender: .user
                ))
        }
        currentPartner = dialogPartnerType

        currentTask = Task {
            do {
                let session = conversations[dialogPartnerType]
                guard let session = session else { return }
                let response = try await session.respond(to: userInput)
                if isLogged {
                    conversationLogs[dialogPartnerType]?.append(Dialog(
                        content: response.content,
                        sender: .partner
                    ))
                }
                isGenerating = false
            } catch {
                isGenerating = false
            }
        }
    }
}
