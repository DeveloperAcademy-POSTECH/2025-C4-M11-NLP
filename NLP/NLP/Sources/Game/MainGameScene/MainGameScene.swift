//
//  MainGameScene.swift
//  SpriteKitExample
//
//  Created by 한건희 on 7/9/25.
//
import Combine
import SpriteKit

class MainGameScene: GameScene {
    var box: BoxSprite?
    var computer: ChapOneComputerSprite?
    weak var gameState: MainGameState?
    
    private var cancellables = Set<AnyCancellable>()
    
    override func setUpScene() {
        super.setUpScene()
        
        physicsWorld.contactDelegate = self
        
        for child in self.children {
            if let computer = child as? ChapOneComputerSprite {
                computer.configurePhysics()
                self.computer = computer
            }
            
            // MARK: 상속 받는 게임 Scene에서 호출
            if let box = child as? BoxSprite {
                box.configurePhysics()
                self.box = box
            }
        }
        
        gameState?.$isChatting
            .receive(on: RunLoop.main)
            .sink { [weak self] isPresented in
                if isPresented {
                    self?.computerInteractionStart()
                } else {
                    self?.computerInteractionEnd()
                }
            }
            .store(in: &cancellables)
    }
}

// MARK: 각 게임 Scene 마다 설정해줘야 함.
extension MainGameScene: SKPhysicsContactDelegate {
    // MARK: 컴퓨터와 플레이어가 부딪힐 때 호출되는 함수
    func didBegin(_ contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node

        if let player = nodeA as? PlayerSprite, let computer = nodeB as? ChapOneComputerSprite {
            // applySoftPush(from: player, to: computer)
            gameState?.isChatting = true
        } else if let player = nodeB as? PlayerSprite, let computer = nodeA as? ChapOneComputerSprite {
            // applySoftPush(from: player, to: computer)
            gameState?.isChatting = true
        }
    }
    
    func computerInteractionStart() {
        guard let player, let computer, let camera else { return }
        
        isJoystickTouchActive = false
        
        player.zPosition = -1

        // ✅ 카메라 애니메이션 이동 + 확대
        let moveAction = SKAction.move(to: computer.position, duration: 0.5)
        let scaleAction = SKAction.scale(to: 0.3, duration: 0.5)
        let group = SKAction.group([moveAction, scaleAction])
        camera.run(group)
    }

    func computerInteractionEnd() {
        guard let player, let camera else { return }

        player.zPosition = 1

        // ✅ 카메라 애니메이션 복귀
        let moveAction = SKAction.move(to: player.position, duration: 0.5)
        let scaleAction = SKAction.scale(to: 1.0, duration: 0.5)
        let group = SKAction.group([moveAction, scaleAction])
        camera.run(group)
    }

    func applySoftPush(from player: PlayerSprite, to box: BoxSprite) {
        guard let playerVelocity = player.physicsBody?.velocity else { return }
        
        let pushForce = CGVector(dx: playerVelocity.dx * 10, dy: playerVelocity.dy * 10)
        box.physicsBody?.applyForce(pushForce)
    }

    // MARK: 보물상자와 플레이어가 멀어졌을 때 호출되는 함수
    func didEnd(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA.node
        let bodyB = contact.bodyB.node
        
        if let player = bodyA as? PlayerSprite, let computer = bodyB as? ChapOneComputerSprite {
            // computerInteractionEnd()
        } else if let player = bodyB as? PlayerSprite, let computer = bodyA as? ChapOneComputerSprite {
            // computerInteractionEnd()
        }
    }
}
