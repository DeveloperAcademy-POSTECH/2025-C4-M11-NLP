//
//  PlayerSprite.swift
//  SpriteKitExample
//
//  Created by 한건희 on 7/8/25.
//

import SpriteKit

class PlayerSprite: SKSpriteNode {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // 픽셀의 선명도를 높이기 위해 안티얼라이징을 사용하지 않도록 설정
        texture?.filteringMode = .nearest
    }
    
    func configurePhysics(playerPhysicsType: PlayerPhysicsType) {
        let footSize = CGSize(width: self.size.width * 0.5, height: 30)
        self.physicsBody = SKPhysicsBody(rectangleOf: footSize)
        switch playerPhysicsType {
        case .normal:
            self.physicsBody?.friction = 0.2 // 기본 마찰력
            self.physicsBody?.linearDamping = 5.0 // 빠르게 천천히 속도를 줄일 수 있도록
            self.physicsBody?.restitution = 0 // 튕김 방지
            self.physicsBody?.usesPreciseCollisionDetection = true // 노드 간 충돌 감지를 더욱 명확하게 하기 위함.
            self.physicsBody?.categoryBitMask = PhysicsCategory.player.rawValue
            self.physicsBody?.contactTestBitMask = PhysicsCategory.wall.rawValue | PhysicsCategory.box.rawValue | PhysicsCategory.computer.rawValue | PhysicsCategory.flashlight.rawValue | PhysicsCategory.robot.rawValue | PhysicsCategory.note.rawValue | PhysicsCategory.oxygen.rawValue | PhysicsCategory.machine.rawValue | PhysicsCategory.killerRobot.rawValue | PhysicsCategory.signalMachine.rawValue | PhysicsCategory.quizMachine.rawValue
            self.physicsBody?.collisionBitMask = PhysicsCategory.wall.rawValue | PhysicsCategory.box.rawValue | PhysicsCategory.computer.rawValue | PhysicsCategory.flashlight.rawValue | PhysicsCategory.robot.rawValue | PhysicsCategory.note.rawValue | PhysicsCategory.oxygen.rawValue | PhysicsCategory.killerRobot.rawValue | PhysicsCategory.signalMachine.rawValue | PhysicsCategory.quizMachine.rawValue
            self.physicsBody?.affectedByGravity = false
            self.physicsBody?.allowsRotation = false
        case .space:
            self.physicsBody?.friction = 0.2 // 기본 마찰력
            self.physicsBody?.linearDamping = 5.0 // 빠르게 천천히 속도를 줄일 수 있도록
            self.physicsBody?.restitution = 0 // 튕김 방지
            self.physicsBody?.usesPreciseCollisionDetection = true // 노드 간 충돌 감지를 더욱 명확하게 하기 위함.
            self.physicsBody?.categoryBitMask = PhysicsCategory.player.rawValue
            self.physicsBody?.contactTestBitMask = PhysicsCategory.wall.rawValue | PhysicsCategory.box.rawValue | PhysicsCategory.flashlight.rawValue | PhysicsCategory.note.rawValue | PhysicsCategory.oxygen.rawValue | PhysicsCategory.quizMachine.rawValue
            self.physicsBody?.collisionBitMask = PhysicsCategory.wall.rawValue | PhysicsCategory.box.rawValue | PhysicsCategory.flashlight.rawValue | PhysicsCategory.note.rawValue | PhysicsCategory.oxygen.rawValue | PhysicsCategory.killerRobot.rawValue | PhysicsCategory.signalMachine.rawValue | PhysicsCategory.quizMachine.rawValue
            self.physicsBody?.affectedByGravity = false
            self.physicsBody?.allowsRotation = false
        }
    }
    
    func movePlayer(direction: CGVector, strength: CGFloat, maxSpeed: CGFloat) {
        let velocity = CGVector(dx: direction.dx * maxSpeed * strength, dy: direction.dy * maxSpeed * strength)
        self.physicsBody?.velocity = velocity
    }
}

