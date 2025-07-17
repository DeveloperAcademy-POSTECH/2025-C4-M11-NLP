//
//  StageTwoScene.swift
//  NLP
//
//  Created by Ted on 7/15/25.
//

import SpriteKit

class StageTwoGameScene: GameScene {
    var robot: RobotSprite?
    var originalRobotPosition: CGPoint?
    var pda: PDASprite?
    weak var viewModel: StageTwoViewModel?
    
    override func setUpScene() {
        super.setUpScene()
        
        physicsWorld.contactDelegate = self
        
        for child in self.children {
            if let robot = child as? RobotSprite {
                robot.configurePhysics()
                self.robot = robot
                self.originalRobotPosition = robot.position
            } else if let pda = child as? PDASprite {
                self.pda = pda
            }
        }
    }
}

extension StageTwoGameScene {
    func robotBringPda() async {
        guard let pda = pda, let robot = robot, let player = player, let originalRobotPosition = originalRobotPosition else { return }
        /// 로봇이 pda를 가지러 이동
        var move = SKAction.move(to: pda.position, duration: 2)
        await robot.run(move)
        
        /// 로봇이 pda를 가지고 원 자리로 이동
        move = SKAction.move(to: originalRobotPosition, duration: 2)
        pda.move(toParent: robot)
        await robot.run(move)
    }
    
    func setPdaTransparent() async {
        guard let pda = pda, let player = player else { return }
        
        let move = SKAction.move(to: player.position, duration: 1)
        let transparent = SKAction.fadeAlpha(to: 0.0, duration: 1)
        let group = SKAction.group([move, transparent])
        
        await pda.run(group)
    }
    
    func setRobotHappy() async {
        guard let robot = robot else { return }
        robot.texture = SKTexture(image: UIImage(named: "robot-happy")!)
    }
}

extension StageTwoGameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        
        if let player = nodeA as? PlayerSprite, let robot = nodeB as? RobotSprite {
            // 충돌 액션 구현
            viewModel?.action(.robotEncountered)
        } else if let robot = nodeA as? RobotSprite, let player = nodeB as? PlayerSprite {
            // 충돌 액션 구현
            viewModel?.action(.robotEncountered)
        }
    }
}
