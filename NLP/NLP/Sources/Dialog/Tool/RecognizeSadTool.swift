//
//  RecognizeSadTool.swift
//  NLP
//
//  Created by Ted on 7/18/25.
//

import FoundationModels

@MainActor
struct RecognizeSadTool: Tool {
    let name = "RecognizeSadTool"
    let description: String
    let recogizedAction: (() -> Void)
    
    init(recogizedAction: @escaping (() -> Void)) {
        self.recogizedAction = recogizedAction
        description = "사용자의 입력 문장이 슬픔에 가까운 문장이라면, recognizedAction 을 호출합니다."
    }
    
    @Generable
    struct Arguments {
        @Guide(description: "입력 문장 전체")
        var password: String
    }
    
    func call(arguments: Arguments) async -> ToolOutput {
        recogizedAction()
        return ToolOutput("슬픈 문장이 입력되었습니다.")
    }
}
