//
//  UnlockTool.swift
//  SpriteKitExample
//
//  Created by 한건희 on 7/9/25.
//

import FoundationModels

struct UnlockTool: Tool {
    let name = "UnlockTool"
    let description: String
    
    init() {
        description = "1010이라는 암호가 들어오면 환영한다는 메세지를 출력합니다."
    }
    
    @Generable
    struct Arguments {
        @Guide(description: "Unknown Command에서 벗어나기 위한 암호")
        var text: String
    }
    
    func call(arguments: Arguments) async -> ToolOutput {
        print("unlockTool called!")
        return ToolOutput("환영합니다! 무엇을 도와드릴까요?")
    }
}
