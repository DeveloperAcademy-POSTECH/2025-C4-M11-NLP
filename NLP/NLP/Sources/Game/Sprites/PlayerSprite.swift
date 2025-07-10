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
            self.physicsBody?.contactTestBitMask = PhysicsCategory.wall.rawValue | PhysicsCategory.box.rawValue | PhysicsCategory.computer.rawValue
            self.physicsBody?.collisionBitMask = PhysicsCategory.wall.rawValue | PhysicsCategory.box.rawValue | PhysicsCategory.computer.rawValue
            self.physicsBody?.affectedByGravity = false
            self.physicsBody?.allowsRotation = false
        case .space:
            self.physicsBody?.friction = 0.2 // 기본 마찰력
            self.physicsBody?.linearDamping = 5.0 // 빠르게 천천히 속도를 줄일 수 있도록
            self.physicsBody?.restitution = 0 // 튕김 방지
            self.physicsBody?.usesPreciseCollisionDetection = true // 노드 간 충돌 감지를 더욱 명확하게 하기 위함.
            self.physicsBody?.categoryBitMask = PhysicsCategory.player.rawValue
            self.physicsBody?.contactTestBitMask = PhysicsCategory.wall.rawValue | PhysicsCategory.box.rawValue
            self.physicsBody?.collisionBitMask = PhysicsCategory.wall.rawValue | PhysicsCategory.box.rawValue
            self.physicsBody?.affectedByGravity = false
            self.physicsBody?.allowsRotation = false
        }
    }
    
    func movePlayer(_ location: CGPoint) {
        guard let physicsBody = self.physicsBody else { return }

        let dx = location.x - position.x
        let dy = location.y - position.y
        let distance = sqrt(dx*dx + dy*dy)

        // 도착한 것으로 간주할 거리 임계값
        let arrivalThreshold: CGFloat = 10.0

        if distance < arrivalThreshold {
            // 위치 보정 및 속도 정지
            physicsBody.velocity = .zero
            position = location // 정확한 위치 보정 (선택)
            return
        }

        let direction = CGVector(
            dx: dx / distance,
            dy: dy / distance
        )
        
        let speed: CGFloat = 250 // 빠르게 이동하고

        // 빠르게, 도착 후 정지.
        // MARK: 박스를 움직일 때 플레이어의 position을 직접 바꿔주는 식으로 하면, 플레이어의 velocity(얼마의 세기로 움직이는지)를 계산하지 못함. 그래서 position.x, position.y 로 설정해주지 않고, physicsBody의 velocity를 설정.
        physicsBody.velocity = CGVector(
            dx: direction.dx * speed,
            dy: direction.dy * speed
        )
    }
}

