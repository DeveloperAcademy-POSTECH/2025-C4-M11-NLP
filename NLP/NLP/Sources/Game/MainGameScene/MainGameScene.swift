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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let camera = self.camera else { return }
        guard let touchLocation = touches.first?.location(in: camera) else { return }

        if self.joyStick.isJoyStickAvailableLocation(touchLocation) {
            isJoystickTouchActive = true
            self.joyStick.startMove(touchLocation)
        } else {
            if let gs = gameState, gs.isChatting { return }
            self.joyStick.createDynamicJoystick(at: touchLocation, camera: camera)
            isJoystickTouchActive = true
            self.joyStick.startMove(touchLocation)
        }
    }
}

// MARK: 각 게임 Scene 마다 설정해줘야 함.
extension MainGameScene: SKPhysicsContactDelegate {
    // MARK: 컴퓨터와 플레이어가 부딪힐 때 호출되는 함수
    func didBegin(_ contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node

        if let _ = nodeA as? PlayerSprite, let _ = nodeB as? ChapOneComputerSprite {
            gameState?.isChatting = true
        } else if let _ = nodeB as? PlayerSprite, let _ = nodeA as? ChapOneComputerSprite {
            gameState?.isChatting = true
        }
    }
    
    func computerInteractionStart() {
        guard let player, let computer, let camera else { return }
        
        isJoystickTouchActive = false
        
        // 채팅시 플레이어와 조이스틱 가리기
        setNodeVisibility(player, visibility: false)
        setNodeVisibility(joyStick.joystickBase, visibility: false)
        setNodeVisibility(joyStick.joystickKnob, visibility: false)


        // 카메라 애니메이션 이동 + 확대
        let targetPosition = CGPoint(x: computer.position.x, y: computer.position.y-30)
        let moveAction = SKAction.move(to: targetPosition, duration: 0.5)
        let scaleAction = SKAction.scale(to: 0.17, duration: 0.5)
        let group = SKAction.group([moveAction, scaleAction])
        camera.run(group)
    }

    func computerInteractionEnd() {
        guard let player, let camera else { return }

        setNodeVisibility(player, visibility: true)

        // 카메라 애니메이션 복귀
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
        
        if let _ = bodyA as? PlayerSprite, let _ = bodyB as? ChapOneComputerSprite {
            // TODO
        } else if let _ = bodyB as? PlayerSprite, let _ = bodyA as? ChapOneComputerSprite {
            // TODO
        }
    }
    
    private func setNodeVisibility(_ node: SKNode, visibility: Bool) {
        node.zPosition = visibility ? 1 : -1
    }
}
