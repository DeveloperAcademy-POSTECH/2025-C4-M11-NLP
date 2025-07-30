//
//  Dialog.swift
//  NLP
//
//  Created by Ted on 7/13/25.
//

import Foundation

/**
 Dialog struct 설명입니다.
 parameter:
  - content: 대화의 내용입니다.
  - sender: 유저가 보낸 대화인지, 상대방이 보낸 대화인지를 구별하는 DialogSender enum 입니다.
 */
struct Dialog: Identifiable, Hashable {
    var id: UUID = UUID()
    var content: String
    var sender: DialogSender
    var fromToolCalling: Bool
    
    init(content: String, sender: DialogSender, fromToolCalling: Bool = false) {
        self.content = content
        self.sender = sender
        self.fromToolCalling = fromToolCalling
    }
}
