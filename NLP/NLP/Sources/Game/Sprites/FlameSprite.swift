//
//  FlameSprite.swift
//  NLP
//
//  Created by 양시준 on 7/24/25.
//

import SpriteKit

class FlameSprite: SKSpriteNode {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        texture?.filteringMode = .nearest
    }
    
}
