//
//  DoorLockSprite.swift
//  NLP
//
//  Created by 양시준 on 7/18/25.
//


import SpriteKit

class DoorSprite: SKSpriteNode {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // ensure no anti-aliasing for crisp pixel art
        texture?.filteringMode = .nearest
    }
    
    func configurePhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width - 20, height: self.size.height - 20))
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.doorLock.rawValue
        self.physicsBody?.contactTestBitMask = PhysicsCategory.player.rawValue | PhysicsCategory.wall.rawValue
        self.physicsBody?.collisionBitMask = PhysicsCategory.player.rawValue | PhysicsCategory.wall.rawValue
        self.physicsBody?.friction = 1
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.isDynamic = false
    }
    
    // 문이 충돌할 때 살짝 흔들리는 효과
    func runShakeEffect() {
        let moveLeft = SKAction.moveBy(x: 0, y: -10, duration: 0.04)
        let moveRight = SKAction.moveBy(x: 0, y: 20, duration: 0.08)
        let moveBack = SKAction.moveBy(x: 0, y: -10, duration: 0.04)
        let shake = SKAction.sequence([moveLeft, moveRight, moveBack])
        self.run(shake)
    }
}
