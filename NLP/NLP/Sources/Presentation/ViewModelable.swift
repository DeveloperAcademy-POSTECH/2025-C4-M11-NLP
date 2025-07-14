//
//  ViewModelable.swift
//  NLP
//
//  Created by Ted on 7/14/25.
//

import SwiftUI

/**
 뷰모델 구현 시 채택해야하는 프로토콜입니다.
 > 뷰모델의 상태를 관리하는 State (struct), 뷰에서 호출할 액션들의 집합인 Action (enum) 정의가 필요합니다. 아래의 "action" 메서드는 뷰로부터 호출되어 action 에 해당하는 로직을 수행하는 메서드이며, 해당 메서드 또한 필수로 구현해주어야 합니다.
 ```swift
 func action(_ action: Action)
 ```
 
 다음은 예시입니다.
 ```swift
 class ExampleViewModel: ViewModelable {
     struct State {
         var userName: String?
         var userAge: Int?
     }
     
     enum Action {
         case increaseAge
     }
     
     @Published var state: State = State()
     
     func action(_ action: Action) {
         switch action {
         case .increaseAge:
             state.userAge? += 1
         }
     }
 }
 ```
 */
protocol ViewModelable: ObservableObject {
    associatedtype State
    associatedtype Action
    
    var state: State { get }
    
    func action(_ action: Action)
}
