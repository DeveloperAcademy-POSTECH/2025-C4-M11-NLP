//
//  QuizTool.swift
//  NLP
//
//  Created by 차원준 on 7/25/25.
//
import FoundationModels

@Generable(description: "It's a number.")
enum Number: Int, CaseIterable {
    case number
//    case middle
//    case high
}

@Generable
struct Quiz {
//    @Guide(description: "About Number")
//    var type: Type
    @Guide(description: "It's a Number.", .range(0 ... 100))
    var number: Int
}

struct QuizTool: Tool {
    let name: String = "Quiz"
    let description: String
    let callAction: (Int) -> Void

    init(callAction: @escaping (Int) -> Void) {
        description = "사용자가 말한 문장에서 숫자(0, 1, 2, 3, 4, 5, 6, 7, 8, 9)만을 추출합니다."
        self.callAction = callAction
    }

    @Generable
    struct Arguments {
        @Guide(description: "About Number")
        var quiz: Quiz
    }

    func call(arguments: Arguments) async throws -> some PromptRepresentable {
        callAction(arguments.quiz.number)
        return ""
    }
}
