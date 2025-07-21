//
//  RecognizeSadTool.swift
//  NLP
//
//  Created by Ted on 7/22/25.
//

import FoundationModels

@MainActor
struct RecognizeJokeTool: Tool {
    let name = "RecognizeJoke"
    let description: String
    let afterRecognizeAction: (() -> Void)
    
    init(afterRecognizeAction: @escaping (() -> Void)) {
        self.afterRecognizeAction = afterRecognizeAction
        description = "Detect and trigger whenever a playful sentence from the user appears!!!!!!!!!!"
    }
    
    @Generable
    struct Arguments {
        @Guide(description: "Here is the user’s full sentence that sounds playful.")
        var jokeSentence: String
    }
    
    func call(arguments: Arguments) async -> ToolOutput {
        afterRecognizeAction()
        return ToolOutput("I can sense playfulness in your sentence. That’s funny, haha!")
    }
}
