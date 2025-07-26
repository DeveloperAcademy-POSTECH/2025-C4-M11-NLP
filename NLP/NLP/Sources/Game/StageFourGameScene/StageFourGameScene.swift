//
//  StageFourGameScene.swift
//  NLP
//
//  Created by Ted on 7/24/25.
//

import SpriteKit


class StageFourGameScene: GameScene {
    
    weak var viewModel: StageFourGameViewModel?
    var robot: RobotSprite?
    
    override func setUpScene() {
        super.setUpScene()
        
        physicsWorld.contactDelegate = self
        
        for child in self.children {
            if let robot = child as? RobotSprite {
                self.robot = robot
                robot.configurePhysics()
            }
        }
    }
}

extension StageFourGameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        
        
    }
}
