//
//  HappyRecognizeTool.swift
//  NLP
//
//  Created by Ted on 7/22/25.
//
import FoundationModels

@MainActor
struct RecognizeHappyTool: Tool {
    let name = "RecognizeHappy"
    let description: String
    let afterRecognizeAction: (() -> Void)
    
    init(afterRecognizeAction: @escaping (() -> Void)) {
        self.afterRecognizeAction = afterRecognizeAction
        description = "Please make sure to detect and trigger whenever a sentence from the user shows happiness or joy!"
    }
    
    @Generable
    struct Arguments {
        @Guide(description: "Here is the user’s full sentence that feels happy.")
        var happySentence: String
    }
    
    func call(arguments: Arguments) -> ToolOutput {
        afterRecognizeAction()
        return ToolOutput("I can feel joy in your sentence. I’m so happy too! :)")
    }
}
