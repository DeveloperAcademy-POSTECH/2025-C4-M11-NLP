//
//  UnlockTool.swift
//  SpriteKitExample
//
//  Created by 한건희 on 7/9/25.
//

import FoundationModels

@MainActor
struct UnlockTool: Tool {
    let name = "UnlockTool"
    let description: String
    let rightPasswordAction: (() -> Void)
    
    init(rightPasswordAction: @escaping (() -> Void)) {
        self.rightPasswordAction = rightPasswordAction
        description = "올바른 암호가 들어왔는지, 아닌지를 판단해주는 툴입니다. 이 Tool을 호출한다면, Unknown Command 가 아니라, 암호에 따라 Right Password. 또는 Wrong Password 를 출력해주세요."
    }
    
    @Generable
    struct Arguments {
        @Guide(description: "암호")
        var password: String
    }
    
    func call(arguments: Arguments) async -> ToolOutput {
        if arguments.password == "1010" {
            rightPasswordAction()
            return ToolOutput("올바른 암호가 입력되었습니다.")
        }
        return ToolOutput("잘못된 암호가 입력되었습니다.")
    }
}
