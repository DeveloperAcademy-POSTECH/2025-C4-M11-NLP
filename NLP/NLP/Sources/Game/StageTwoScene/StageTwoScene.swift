//
//  StageTwoScene.swift
//  NLP
//
//  Created by Ted on 7/15/25.
//

import SpriteKit

class StageTwoScene: GameScene {
    var robot: RobotSprite?
    weak var viewModel: StageTwoViewModel?
    
    override func setUpScene() {
        super.setUpScene()
        
        physicsWorld.contactDelegate = self
        
        for child in self.children {
            if let robot = child as? RobotSprite {
                robot.configurePhysics()
                self.robot = robot
            }
        }
    }
}

extension StageTwoScene: SKPhysicsContactDelegate {
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
