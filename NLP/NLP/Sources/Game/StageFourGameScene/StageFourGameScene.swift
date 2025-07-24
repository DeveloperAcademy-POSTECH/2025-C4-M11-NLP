//
//  StageFourGameScene.swift
//  NLP
//
//  Created by Ted on 7/24/25.
//

import SpriteKit


class StageFourGameScene: GameScene {
    
    weak var viewModel: StageFourGameViewModel?
    
    override func setUpScene() {
        super.setUpScene()
        
        physicsWorld.contactDelegate = self
        
        for child in self.children {
            
        }
    }
}

extension StageFourGameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        
        
    }
}
