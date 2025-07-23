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
        description = "사용자의 행복과 기쁨이 나타나는 문장을 반드시 인식해 호출하세요! 제발!"
    }
    
    @Generable
    struct Arguments {
        @Guide(description: "행복이 느껴지는 사용자의 전체 문장입니다.")
        var happySentence: String
    }
    
    func call(arguments: Arguments) -> ToolOutput {
        afterRecognizeAction()
        return ToolOutput("문장에서 기쁨이 느껴져요. 저도 너무 기뻐요 :)")
    }
}
