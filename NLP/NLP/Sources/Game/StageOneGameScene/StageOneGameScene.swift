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
    var note: NoteSprite?
    var doorLock: DoorLockSprite?
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
            
            if let note = child as? NoteSprite {
                note.configurePhysics()
                self.note = note
            }
            
            if let doorLock = child as? DoorLockSprite {
                doorLock.configurePhysics()
                self.doorLock = doorLock
            }
            
            if let player = child as? PlayerSprite {
                for child in player.children {
                    if let noLight = child as? NoLightSprite {
                        self.noLight = noLight
                        self.noLight?.alpha = 1
                    }
                    
                    if let turnOnFlashlight = child as? TurnOnFlashlightSprite {
                        self.turnOnFlashlight = turnOnFlashlight
                        self.turnOnFlashlight?.alpha = 0
                    }
                }
            }
        }
        
        viewModel?.$state
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                // 왜 이렇게 isDialogPresented 로 분기를 하는가. 를 생각해보자.
                if state.isDialogPresented {
                    self?.dialogPresentStart()
                } else {
                    self?.dialogPresentEnd()
                }
                if state.isChatting {
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

        // 조이스틱이 이미 존재하는 경우에만 조이스틱 영역 체크
        if self.joyStick.joystickBase != nil && self.joyStick.isJoyStickAvailableLocation(touchLocation) {
            isJoystickTouchActive = true
            self.joyStick.startMove(touchLocation)
        } else {
            if let gs = viewModel?.state, gs.isChatting { return }
            // 조이스틱이 없거나 조이스틱 영역이 아닌 경우 새로운 조이스틱 생성
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
            viewModel?.action(.showFlashlightFoundPresented)
        } else if let _ = nodeA as? FlashlightSprite, let _ = nodeB as? PlayerSprite {
            viewModel?.action(.showFlashlightFoundPresented)
        } else if let _ = nodeA as? PlayerSprite, let _ = nodeB as? NoteSprite {
            viewModel?.action(.showNoteFoundPresented)
        } else if let _ = nodeA as? NoteSprite, let _ = nodeB as? PlayerSprite {
            viewModel?.action(.showNoteFoundPresented)
        } else if let _ = nodeA as? PlayerSprite, let _ = nodeB as? DoorLockSprite {
            viewModel?.action(.showPasswordView)
        } else if let _ = nodeA as? DoorLockSprite, let _ = nodeB as? PlayerSprite {
            viewModel?.action(.showPasswordView)
        }
    }
    
    func dialogPresentStart() {
        isJoystickTouchActive = false
        // 조이스틱이 존재하는 경우에만 숨김
        if joyStick.joystickBase != nil {
            setNodeVisibility(joyStick.joystickBase, visibility: false)
            setNodeVisibility(joyStick.joystickKnob, visibility: false)
        }
    }
    
    func dialogPresentEnd() {
        isJoystickTouchActive = true
        // 조이스틱이 존재하는 경우에만 표시
        if joyStick.joystickBase != nil {
            setNodeVisibility(joyStick.joystickBase, visibility: true)
            setNodeVisibility(joyStick.joystickKnob, visibility: true)
        }
    }
    
    func moveToCenteralControlRoom(completion: @escaping () -> Void) {
        // 위치 미정
        let moveAction = SKAction.move(to: ConstantPositions.centeralControlRoomDoorPoisition, duration: 3.0)
        if let player = player {
            player.run(moveAction) {
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    func computerInteractionStart() {
        guard let player, let computer, let camera else { return }
        
        isJoystickTouchActive = false
        
        // 채팅시 플레이어와 조이스틱 가리기
        setNodeVisibility(player, visibility: false)
        // 조이스틱이 존재하는 경우에만 숨김
        if joyStick.joystickBase != nil {
            setNodeVisibility(joyStick.joystickBase, visibility: false)
            setNodeVisibility(joyStick.joystickKnob, visibility: false)
        }

        // 카메라 애니메이션 이동 + 확대
        let targetPosition = CGPoint(x: computer.position.x, y: computer.position.y-30)
        let moveAction = SKAction.move(to: targetPosition, duration: 0.5)
        let scaleAction = SKAction.scale(to: 0.3, duration: 0.5)
        let group = SKAction.group([moveAction, scaleAction])
        camera.run(group)
    }

    func computerInteractionEnd() {
        guard let player, let camera else { return }

        setNodeVisibility(player, visibility: true)
        // 조이스틱이 존재하는 경우에만 표시
        if joyStick.joystickBase != nil {
            setNodeVisibility(joyStick.joystickBase, visibility: true)
            setNodeVisibility(joyStick.joystickKnob, visibility: true)
        }

        // 카메라 애니메이션 복귀
        let moveAction = SKAction.move(to: player.position, duration: 0.5)
        let scaleAction = SKAction.scale(to: 1.0, duration: 0.5)
        let group = SKAction.group([moveAction, scaleAction])
        camera.run(group)
    }

    
    func changeLightMode(lightMode: LightMode) {
        guard let noLight, let turnOnFlashlight else { return }
        switch lightMode {
        case .noLight:
            noLight.alpha = 1
            turnOnFlashlight.alpha = 0
        case .turnOnFlashlight:
            noLight.alpha = 0
            turnOnFlashlight.alpha = 1
        case .lightOn:
            noLight.alpha = 0
            turnOnFlashlight.alpha = 0
        }
    }
    

    
    func hideFlashlight() {
        guard let flashlight else { return }
        flashlight.removeFromParent()
    }
    
    func hideNote() {
        guard let note else { return }
        note.removeFromParent()
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
