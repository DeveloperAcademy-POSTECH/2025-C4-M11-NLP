//
//  OxygenTool.swift
//  NLP
//
//  Created by 차원준 on 7/24/25.
//

import FoundationModels

@Generable(description: "About oxygen")
enum Type: String, CaseIterable {
    case oxygen
}

@Generable(description: "It's about degree of oxygen.")
enum DegreeOfOxygen: String, CaseIterable {
    case low
    case middle
    case high
}

@Generable
struct Oxygengauge {
    @Guide(description: "About oxygen")
    var type: Type
    @Guide(description: "It's about degree of oxygen.")
    var degreeOfOxygen: DegreeOfOxygen
}

struct OxygenTool: Tool {
    let name: String = "generateOxygen"
    let description: String

    init() {
        description = "사용자가 말한 문장에서 산소 부족과 관련된 내용을 감지합니다."
    }

    @Generable
    struct Arguments {
        @Guide(description: "산소 농도에 관한 정보입니다.")
        var oxygengauge: Oxygengauge
    }

    func call(arguments: Arguments) async throws -> some PromptRepresentable {
        print("사용자가 부족한 것의 정도는 \(arguments.oxygengauge.degreeOfOxygen)이고 부족한 종류는 \(arguments.oxygengauge.type) 입니다.")
        return ""
    }
}
