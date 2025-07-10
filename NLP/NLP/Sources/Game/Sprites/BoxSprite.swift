//
//  BoxSprite.swift
//  SpriteKitExample
//
//  Created by 한건희 on 7/8/25.
//

import SpriteKit

class BoxSprite: SKSpriteNode {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // ensure no anti-aliasing for crisp pixel art
        texture?.filteringMode = .nearest
    }
    
    // TODO:
    func configurePhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width - 20, height: self.size.height - 20))
        self.physicsBody?.usesPreciseCollisionDetection = true // MARK: 추가로, 벽은 정적 물체이므로 굳이 해당 코드를 작성해줄 필요는 없음.
        self.physicsBody?.categoryBitMask = PhysicsCategory.box.rawValue
        self.physicsBody?.contactTestBitMask = PhysicsCategory.player.rawValue | PhysicsCategory.wall.rawValue
        self.physicsBody?.collisionBitMask = PhysicsCategory.player.rawValue | PhysicsCategory.wall.rawValue
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.friction = 0.3              // 미끄러지지 않게 적당히 마찰
        self.physicsBody?.restitution = 0.0           // 튀지 않게
        self.physicsBody?.linearDamping = 2.0         // 점점 속도 줄어들게
    }
}
