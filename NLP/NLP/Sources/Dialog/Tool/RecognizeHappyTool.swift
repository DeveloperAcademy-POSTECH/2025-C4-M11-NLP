//
//  RecognizeHappyTool.swift
//  NLP
//
//  Created by Ted on 7/18/25.
//

import FoundationModels

@MainActor
struct RecognizeHappyTool: Tool {
    let name = "RecognizeHappyTool"
    let description: String
    let recogizedAction: (() -> Void)
    
    init(recogizedAction: @escaping (() -> Void)) {
        self.recogizedAction = recogizedAction
        description = "사용자의 입력 문장이 행복에 가까운 문장이라면, recognizedAction 을 호출합니다."
    }
    
    @Generable
    struct Arguments {
        @Guide(description: "입력 문장 전체")
        var sentence: String
    }
    
    func call(arguments: Arguments) async -> ToolOutput {
        recogizedAction()
        return ToolOutput("행복한 문장이 입력되었습니다.")
    }
}
