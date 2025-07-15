//
//  RobotSprite.swift
//  NLP
//
//  Created by Ted on 7/15/25.
//

import SpriteKit

class RobotSprite: SKSpriteNode {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        texture?.filteringMode = .nearest
    }
    
    func configurePhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
        self.physicsBody?.friction = 0.2 // 기본 마찰력
        self.physicsBody?.linearDamping = 5.0 // 빠르게 천천히 속도를 줄일 수 있도록
        self.physicsBody?.restitution = 0 // 튕김 방지
        self.physicsBody?.categoryBitMask = PhysicsCategory.robot.rawValue
        self.physicsBody?.contactTestBitMask = PhysicsCategory.player.rawValue
        self.physicsBody?.collisionBitMask = PhysicsCategory.player.rawValue
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.isDynamic = false
    }
}
