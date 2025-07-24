//
//  SignalMachineSprite.swift
//  NLP
//
//  Created by 양시준 on 7/24/25.
//

import SpriteKit

class SignalMachineSprite: SKSpriteNode {
    func configurePhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
        self.physicsBody?.categoryBitMask = PhysicsCategory.signalMachine.rawValue
        self.physicsBody?.contactTestBitMask = PhysicsCategory.player.rawValue
        self.physicsBody?.collisionBitMask = PhysicsCategory.player.rawValue
        self.physicsBody?.friction = 1
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.isDynamic = false
    }
}
