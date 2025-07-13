//
//  MainGameState.swift
//  SpriteKitExample
//
//  Created by 한건희 on 7/9/25.
//

import Combine

class MainGameState: ObservableObject {
    @Published var isPaused: Bool = false
    @Published var isChatting: Bool = false
}
