//  ChatBotSettingSprite.swift
//  NLP

import SpriteKit

class ChatBotSettingSprite: SKSpriteNode {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        texture?.filteringMode = .nearest
    }
    
    func configurePhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width - 20, height: self.size.height - 20))
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.computer.rawValue // 기존 컴퓨터와 동일하게 처리
        self.physicsBody?.contactTestBitMask = PhysicsCategory.player.rawValue
        self.physicsBody?.collisionBitMask = PhysicsCategory.player.rawValue
        self.physicsBody?.friction = 1
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.isDynamic = false
    }
} 