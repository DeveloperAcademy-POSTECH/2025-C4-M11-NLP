//
//  MachineSprite.swift
//  NLP
//
//  Created by (YourName) on (Date).
//

import SpriteKit

/// 특수 기계(퍼즐 등)와 상호작용하는 스프라이트
class MachineSprite: SKSpriteNode {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        texture?.filteringMode = .nearest
    }
    
    /// 물리 엔진 설정: 플레이어와의 접촉만 감지, 통과 가능
    func configurePhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width - 20, height: self.size.height - 20))
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.machine.rawValue
        self.physicsBody?.contactTestBitMask = PhysicsCategory.player.rawValue | PhysicsCategory.wall.rawValue // 플레이어와의 접촉만 감지
        self.physicsBody?.collisionBitMask = PhysicsCategory.player.rawValue  | PhysicsCategory.wall.rawValue // 벽 등과만 충돌, 플레이어는 통과
        self.physicsBody?.friction = 1
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.isDynamic = false
    }

}



