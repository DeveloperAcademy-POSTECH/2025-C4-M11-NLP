//
//  ChapOneComputerSprite.swift
//  SpriteKitExample
//
//  Created by 한건희 on 7/9/25.
//

import SpriteKit

class ChapOneComputerSprite: SKSpriteNode {
    // TODO: Foundation Model 설정
    
    func configurePhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
        self.physicsBody?.categoryBitMask = PhysicsCategory.computer.rawValue
        self.physicsBody?.contactTestBitMask = PhysicsCategory.player.rawValue
        self.physicsBody?.collisionBitMask = PhysicsCategory.player.rawValue
        self.physicsBody?.friction = 1
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.isDynamic = false
    }
}
