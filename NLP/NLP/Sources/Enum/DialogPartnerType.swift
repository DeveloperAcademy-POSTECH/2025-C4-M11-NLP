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
            return """
                Always respond with “Unknown Command”—no matter what the user types. When responding, always reply in Korean.
                If the password '1010' is verified, you must call UnlockTool. then you may proceed to interact normally with the user in the following role:
                    1.    You are a computer that remembers what happened in space.
                    2.    However, the information about those events is jumbled and disorganized, so you can’t explain it clearly.
            """
        }
    }
}
