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
        description = "사용자의 장난이 나타나는 문장을 인식하여 호출하세요!!!!!!!!!!"
    }
    
    @Generable
    struct Arguments {
        @Guide(description: "장난이 느껴지는 사용자의 전체 문장입니다.")
        var jokeSentence: String
    }
    
    func call(arguments: Arguments) async -> ToolOutput {
        afterRecognizeAction()
        return ToolOutput("문장에서 장난이 느껴지네요. 재밌습니다 ㅎㅎ")
    }
}
