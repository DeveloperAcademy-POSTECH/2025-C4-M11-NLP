//
//  QuizTool.swift
//  NLP
//
//  Created by 차원준 on 7/25/25.
//
import FoundationModels


@Generable(description: "It's about number.")
enum Number: String, CaseIterable {
    case low
    case middle
    case high
}

@Generable
struct Quiz {
    @Guide(description: "About Number")
    var type: Type
    @Guide(description: "It's about degree of Number.")
    var degreeOfNumber: Number
}

struct QuizTool: Tool {
    let name: String = "Quiz"
    let description: String
    let callAction: (String) -> Void
    
    init(callAction: @escaping (String) -> Void) {
        description = "사용자가 말한 문장에서 산소 부족과 관련된 내용을 감지합니다."
        self.callAction = callAction
    }
    
    @Generable
    struct Arguments {
        @Guide(description: "About Number")
        var quiz: Quiz
    }
    
    func call(arguments: Arguments) async throws -> some PromptRepresentable {
        callAction(arguments.quiz.type.rawValue)
        return ""
    }
    
    
}
