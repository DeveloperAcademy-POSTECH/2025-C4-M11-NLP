//
//  StageThreeGameScene.swift
//  NLP
//
//  Created by 양시준 on 7/22/25.
//

import SpriteKit

class StageThreeGameScene: GameScene {
    var robot: RobotSprite?
    var finn: FinnSprite?
    var killerRobot: KillerRobotSprite?
    
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
}
