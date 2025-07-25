//
//  StageThreeGameScene.swift
//  NLP
//
//  Created by 양시준 on 7/22/25.
//

import Combine
import SpriteKit

class StageThreeGameScene: GameScene {
    var robot: RobotSprite?
    var finn: FinnSprite?
    var killerRobot: KillerRobotSprite?
    var signalMachine: SignalMachineSprite?
    var flame: FlameSprite?
    var door: DoorLockSprite?
    var jane: JaneSprite?
    
    private var cancellables = Set<AnyCancellable>()
    var isAutoMoving: Bool = false // 자동 이동 중 여부
    
    weak var viewModel: StageThreeViewModel?
    
    override func setUpScene() {
        super.setUpScene()
        
        physicsWorld.contactDelegate = self
        
        for child in self.children {
            if let robot = child as? RobotSprite {
                robot.configurePhysics()
                self.robot = robot
            } else if let finn = child as? FinnSprite {
                finn.configurePhysics()
                self.finn = finn
            } else if let killerRobot = child as? KillerRobotSprite {
                killerRobot.configurePhysics()
                self.killerRobot = killerRobot
            } else if let signalMachine = child as? SignalMachineSprite {
                signalMachine.configurePhysics()
                self.signalMachine = signalMachine
            } else if let flame = child as? FlameSprite {
                self.flame = flame
            } else if let door = child as? DoorLockSprite {
                self.door = door
            } else if let jane = child as? JaneSprite {
                self.jane = jane
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isAutoMoving { return } // 자동 이동 중엔 터치 무시
        guard let camera = self.camera else { return }
        guard let touchLocation = touches.first?.location(in: camera) else { return }
        
        // 조이스틱이 이미 존재하는 경우에만 조이스틱 영역 체크
        if self.joyStick.joystickBase != nil && self.joyStick.isJoyStickAvailableLocation(touchLocation) {
            isJoystickTouchActive = true
            self.joyStick.startMove(touchLocation)
        } else {
            // 조이스틱이 없거나 조이스틱 영역이 아닌 경우 새로운 조이스틱 생성
            self.joyStick.createDynamicJoystick(at: touchLocation, camera: camera)
            isJoystickTouchActive = true
            self.joyStick.startMove(touchLocation)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isAutoMoving { return } // 자동 이동 중엔 터치 무시
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isAutoMoving { return } // 자동 이동 중엔 터치 무시
        super.touchesEnded(touches, with: event)
    }
}

extension StageThreeGameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        
        if let _ = nodeA as? PlayerSprite, let _ = nodeB as? SignalMachineSprite {
            viewModel?.state.isSignalMachinePresented = true
        } else if let _ = nodeB as? PlayerSprite, let _ = nodeA as? SignalMachineSprite {
            viewModel?.state.isSignalMachinePresented = true
        }
    }
    
    func moveToFinn(completion: @escaping () -> Void) {
        isAutoMoving = true
        let playerMoveAction = SKAction.move(to: ConstantPositions.passedOutFinnPlayerPosition, duration: 3.0)
        if let player = player {
            player.run(playerMoveAction) { [weak self] in
                DispatchQueue.main.async {
                    self?.isAutoMoving = false
                    completion()
                }
            }
        }
        
        let robotMoveAction = SKAction.move(to: ConstantPositions.passedOutFinnRobotPosition, duration: 3.0)
        if let robot = robot {
            robot.run(robotMoveAction) { [weak self] in
                DispatchQueue.main.async {
                    self?.isAutoMoving = false
                }
            }
        }
    }
    
    func changeRobotToDead() {
        if let robot = robot {
            robot.texture = SKTexture(imageNamed: "robot-dead")
        }
    }
    
    func showKillerRobot() {
        if let killerRobot = killerRobot {
            killerRobot.isHidden = false
        }
    }
    
    func hideKillerRobot() {
        if let killerRobot = killerRobot {
            killerRobot.isHidden = true
        }
    }
    
    func standUpFinn() {
        if let finn = finn {
            finn.texture = SKTexture(imageNamed: "Finn")
        }
    }
    
    func moveToSignalMachine() {
        isAutoMoving = true
        let playerMoveAction = SKAction.move(to: ConstantPositions.signalMachinePosition, duration: 3.0)
        if let player = player {
            player.run(playerMoveAction) { [weak self] in
                DispatchQueue.main.async {
                    self?.isAutoMoving = false
                }
            }
        }
    }
    
    func changePositionPlayerToSignalMachine() {
        guard let player else { return }
        
        let targetPosition = ConstantPositions.signalMachinePosition
        player.position = targetPosition
    }
    
    func moveToSignalMachineFinn(completion: @escaping () -> Void) {
        isAutoMoving = true
        let finnMoveAction = SKAction.move(to: ConstantPositions.signalMachineFinnPosition, duration: 3.0)
        if let finn = finn {
            finn.run(finnMoveAction) { [weak self] in
                DispatchQueue.main.async {
                    self?.isAutoMoving = false
                    completion()
                }
            }
        }
    }
    
    func moveToSignalMachineRobot() {
        isAutoMoving = true
        let robotMoveAction = SKAction.move(to: ConstantPositions.signalMachineRobotPosition, duration: 3.0)
        if let robot = robot {
            robot.run(robotMoveAction) { [weak self] in
                DispatchQueue.main.async {
                    self?.isAutoMoving = false
                }
            }
        }
    }
    
    func changeRobotToNew() {
        if let robot = robot {
            robot.texture = SKTexture(imageNamed: "robot-new")
        }
    }
    
    func signalMachineInteractionStart() {
        guard let player, let signalMachine, let camera else { return }
        
        setNodeVisibility(player, visibility: false)
        let targetPosition = CGPoint(x: signalMachine.position.x, y: signalMachine.position.y-30)
        let moveAction = SKAction.move(to: targetPosition, duration: 0.5)
        let scaleAction = SKAction.scale(to: 0.3, duration: 0.5)
        let group = SKAction.group([moveAction, scaleAction])
        camera.run(group)
    }
    
    func signalMachineInteractionEnd() {
        guard let player, let camera else { return }
        
        setNodeVisibility(player, visibility: true)
        let moveAction = SKAction.move(to: player.position, duration: 0.5)
        let scaleAction = SKAction.scale(to: 1.0, duration: 0.5)
        let group = SKAction.group([moveAction, scaleAction])
        camera.run(group)
    }
    
    func changePositionPlayerToPlazmaRoomDoor() {
        guard let player else { return }
        
        let targetPosition = ConstantPositions.plazmaRoomDoorPlayerPosition
        player.position = targetPosition
    }
    
    func changePositionFinnToPlazmaRoomDoor() {
        guard let finn else { return }
        
        let targetPosition = ConstantPositions.plazmaRoomDoorFinnPosition
        finn.position = targetPosition
    }
    
    func changePositionRobotToPlazmaRoomDoor() {
        guard let robot else { return }
        
        let targetPosition = ConstantPositions.plazmaRoomDoorRobotPosition
        robot.position = targetPosition
    }
    
    func moveToPlazmaRoomDoor(completion: @escaping () -> Void) {
        guard let player else { return }
        
        isAutoMoving = true
        let targetPosition = ConstantPositions.plazmaRoomDoorPlayerPosition
        let moveAction = SKAction.move(to: targetPosition, duration: 3)
        player.run(moveAction) { [weak self] in
            DispatchQueue.main.async {
                self?.isAutoMoving = false
                completion()
            }
        }
    }
    
    func moveFinnToPlazmaRoomDoor() {
        guard let finn else { return }
        
        let targetPosition = ConstantPositions.plazmaRoomDoorFinnPosition
        let moveAction = SKAction.move(to: targetPosition, duration: 3)
        finn.run(moveAction)
    }
    
    func moveRobotToPlazmaRoomDoor() {
        guard let robot else { return }
        
        let targetPosition = ConstantPositions.plazmaRoomDoorRobotPosition
        let moveAction = SKAction.move(to: targetPosition, duration: 3)
        robot.run(moveAction)
    }
    
    func movePlayerToAnalyzeDoor() {
        guard let player else { return }
        
        let targetPosition = ConstantPositions.analyzeDoorPlayerPosition
        let moveAction = SKAction.move(to: targetPosition, duration: 0.5)
        player.run(moveAction)
    }
    
    func moveFinnToAnalyzeDoor() {
        guard let finn else { return }
        
        let targetPosition = ConstantPositions.analyzeDoorFinnPosition
        let moveAction = SKAction.move(to: targetPosition, duration: 0.5)
        finn.run(moveAction)
    }
    
    func moveRobotToAnalyzeDoor() {
        guard let robot else { return }
        
        let targetPosition = ConstantPositions.analyzeDoorRobotPosition
        let moveAction = SKAction.move(to: targetPosition, duration: 0.5)
        robot.run(moveAction)
    }
    
    func showFlame() {
        flame?.isHidden = false
    }
    
    func hideFlame() {
        flame?.isHidden = true
    }
    
    func explodeAnimation() {
        let textures: [SKTexture] = [
            SKTexture(imageNamed: "flame1"),
            SKTexture(imageNamed: "flame2"),
            SKTexture(imageNamed: "flame3"),
            SKTexture(imageNamed: "flame4"),
            SKTexture(imageNamed: "flame5"),
            SKTexture(imageNamed: "flame6"),
            SKTexture(imageNamed: "flame5"),
            SKTexture(imageNamed: "flame4"),
            SKTexture(imageNamed: "flame3"),
            SKTexture(imageNamed: "flame2"),
            SKTexture(imageNamed: "flame1"),
        ]
        let timePerFrame: TimeInterval = 0.3
        
        let animationAction = SKAction.animate(with: textures, timePerFrame: timePerFrame)

        if let flame = flame {
            flame.run(animationAction)
        }
    }
    
    func hideDoor() {
        door?.isHidden = true
    }
    
    func moveRobotToAfterExplosion() {
        guard let robot else { return }
        
        let targetPosition = ConstantPositions.afterExplosionRobotPosition
        let moveAction = SKAction.move(to: targetPosition, duration: 2)
        let rotateAction = SKAction.rotate(byAngle: CGFloat.pi/3, duration: 0.5)
        robot.run(moveAction)
        robot.run(rotateAction)
    }
    
    func moveAfterExplosionJanePosition() {
        guard let jane else { return }
        
        let targetPosition = ConstantPositions.afterExplosionJanePosition
        let moveAction = SKAction.move(to: targetPosition, duration: 3)
        jane.run(moveAction)
    }
    
    private func setNodeVisibility(_ node: SKNode, visibility: Bool) {
        node.zPosition = visibility ? 1 : -1
    }
}
