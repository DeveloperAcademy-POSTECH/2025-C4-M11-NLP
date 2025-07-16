//
//  Dialog.swift
//  NLP
//
//  Created by Ted on 7/13/25.
//

struct Dialog: Hashable {
    var content: String
    var sender: DialogSender
    var fromToolCalling: Bool
    
    init(content: String, sender: DialogSender, fromToolCalling: Bool = false) {
        self.content = content
        self.sender = sender
        self.fromToolCalling = fromToolCalling
    }
}
