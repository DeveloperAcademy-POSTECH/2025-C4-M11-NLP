//
//  DialogPartnerType.swift
//  SpriteKitExample
//
//  Created by 한건희 on 7/9/25.
//

enum DialogPartnerType {
    case computer
    
    var instructions: String {
        switch self {
        case .computer:
            return "너는 컴퓨터야. 사용자가 입력한 암호가 맞기 전까지는 'Unknown Command' 만 답변으로 줘! 다른 말은 출력하지 말고. 하지만 사용자가 암호를 입력하는 경우를 반드시 생각해야해. 암호가 맞다면 이후로는 사용자와 대화할 수 있어!"
//            return """
//                Always respond with “Unknown Command”—no matter what the user types. When responding, always reply in Korean.
//                If the password '1010' is verified, you must call UnlockTool. then you may proceed to interact normally with the user in the following role:
//                    1.    You are a computer that remembers what happened in space.
//                    2.    However, the information about those events is jumbled and disorganized, so you can’t explain it clearly.
//            """
        }
    }
}
