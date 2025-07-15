//
//  NoLightSprite.swift
//  NLP
//
//  Created by 양시준 on 7/15/25.
//

import SpriteKit

class NoLightSprite: SKSpriteNode {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        texture?.filteringMode = .nearest
    }
    
}
