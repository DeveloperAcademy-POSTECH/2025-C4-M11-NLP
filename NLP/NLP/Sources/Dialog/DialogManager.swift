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
    @Published var nextUtterance: String?
    @Published var isGenerating = false
    @Published var currentPartner: DialogPartnerType?
    @Published var conversationLogs: [DialogPartnerType: [Dialog]] = [:]
    
    private var currentTask: Task<Void, Never>?
    private var conversations: [DialogPartnerType: LanguageModelSession] = [:]
    
    func initConversation(dialogPartner: DialogPartnerType) {
        let newSession: LanguageModelSession = LanguageModelSession(
            model: .default,
            tools: [UnlockTool()],
            instructions: dialogPartner.instructions
        )
        newSession.prewarm()
        conversations[dialogPartner] = newSession
        conversationLogs[dialogPartner] = []
    }
    
    func respond(_ userInput: String, dialogPartnerType: DialogPartnerType, isLogged: Bool) {
        if isLogged { conversationLogs[dialogPartnerType]?.append(Dialog(content: userInput, sender: .user)) }
        currentPartner = dialogPartnerType

        currentTask = Task {
            do {
                let session = conversations[dialogPartnerType]
                guard let session = session else { return }
                let response = try await session.respond(to: userInput)
                if isLogged { conversationLogs[dialogPartnerType]?.append(Dialog(content: response.content, sender: .partner)) }
                print("저장됨. \(response.content)")
                // nextUtterance = response.content
                isGenerating = false
            } catch {
                nextUtterance = "error"
                isGenerating = false
            }
        }
    }
}

struct Dialog: Hashable {
    var content: String
    var sender: DialogSender
}
