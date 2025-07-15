//
//  StageOneGameScene.swift
//  NLP
//
//  Created by 양시준 on 7/14/25.
//

import Combine
import SpriteKit

class StageOneGameScene: GameScene {
    var box: BoxSprite?

    var computer: ChapOneComputerSprite?
    var flashlight: FlashlightSprite?
    var noLight: NoLightSprite?
    var turnOnFlashlight: TurnOnFlashlightSprite?
    weak var viewModel: StageOneGameViewModel?
    
    private var cancellables = Set<AnyCancellable>()
    
    override func setUpScene() {
        super.setUpScene()
        
        physicsWorld.contactDelegate = self
        
        for child in self.children {
            if let computer = child as? ChapOneComputerSprite {
                computer.configurePhysics()
                self.computer = computer
            }
            
            if let box = child as? BoxSprite {
                box.configurePhysics()
                self.box = box
            }
            
            if let flashlight = child as? FlashlightSprite {
                flashlight.configurePhysics()
                self.flashlight = flashlight
            }
            
            if let player = child as? PlayerSprite {
                for child in player.children {
                    if let noLight = child as? NoLightSprite {
                        self.noLight = noLight
                    }
                    
                    if let turnOnFlashlight = child as? TurnOnFlashlightSprite {
                        self.turnOnFlashlight = turnOnFlashlight
                    }
                }
            }
//            if let noLight = child as? NoLightSprite {
//                self.noLight = noLight
//            }
//            
//            if let turnOnFlashlight = child as? TurnOnFlashlightSprite {
//                self.turnOnFlashlight = turnOnFlashlight
//            }
        }
        
        viewModel?.$state
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                if state.isChatting {
                    self?.computerInteractionStart()
                } else {
                    self?.computerInteractionEnd()
                }
                if state.isFoundFlashlight {
                    self?.flashlightInteractionStart()
                }
                if state.hasFlashlight {
                    self?.flashlightInteractionEnd()
                }
                if state.isFlashlightOn {
                    self?.showFlashlight()
                } else {
                    self?.showNoFlashlight()
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
            if let gs = viewModel?.state, gs.isChatting { return }
            self.joyStick.createDynamicJoystick(at: touchLocation, camera: camera)
            isJoystickTouchActive = true
            self.joyStick.startMove(touchLocation)
        }
    }
}

// MARK: 각 게임 Scene 마다 설정해줘야 함.
extension StageOneGameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node

        if let _ = nodeA as? PlayerSprite, let _ = nodeB as? ChapOneComputerSprite {
            viewModel?.state.isChatting = true
        } else if let _ = nodeB as? PlayerSprite, let _ = nodeA as? ChapOneComputerSprite {
            viewModel?.state.isChatting = true
        } else if let _ = nodeA as? PlayerSprite, let _ = nodeB as? FlashlightSprite {
            viewModel?.action(.findFlashlight)
        } else if let _ = nodeA as? FlashlightSprite, let _ = nodeB as? PlayerSprite {
            viewModel?.action(.findFlashlight)
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
    
    func flashlightInteractionStart() {
        isJoystickTouchActive = false
    }
    
    func flashlightInteractionEnd() {
        guard let flashlight else { return }
        
        isJoystickTouchActive = true
        
        flashlight.removeFromParent()
    }
    
    func showFlashlight() {
        guard let turnOnFlashlight, let noLight else { return }
//        guard let noLight else { return }
        print("show flashlight")
        turnOnFlashlight.alpha = 1
        noLight.alpha = 0
        setNodeVisibility(noLight, visibility: false)
    }
    
    func showNoFlashlight() {
        guard let turnOnFlashlight, let noLight else { return }
//        guard let noLight else { return }
        turnOnFlashlight.alpha = 0
        noLight.alpha = 1
    }

    func applySoftPush(from player: PlayerSprite, to box: BoxSprite) {
        guard let playerVelocity = player.physicsBody?.velocity else { return }
        
        let pushForce = CGVector(dx: playerVelocity.dx * 10, dy: playerVelocity.dy * 10)
        box.physicsBody?.applyForce(pushForce)
    }

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
