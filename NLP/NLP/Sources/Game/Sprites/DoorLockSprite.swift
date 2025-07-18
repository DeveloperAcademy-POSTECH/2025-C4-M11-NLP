//
//  DoorLockSprite.swift
//  NLP
//
//  Created by 양시준 on 7/18/25.
//


import SpriteKit

class DoorLockSprite: SKSpriteNode {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // ensure no anti-aliasing for crisp pixel art
        texture?.filteringMode = .nearest
    }
    
    func configurePhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width - 20, height: self.size.height - 20))
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.note.rawValue
        self.physicsBody?.contactTestBitMask = PhysicsCategory.player.rawValue
        self.physicsBody?.collisionBitMask = PhysicsCategory.player.rawValue
        self.physicsBody?.friction = 1
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.isDynamic = false
    }
}
