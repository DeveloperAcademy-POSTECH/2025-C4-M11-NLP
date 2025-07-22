//
//  StageThreeGameScene.swift
//  NLP
//
//  Created by 양시준 on 7/22/25.
//

import SpriteKit

class StageThreeGameScene: GameScene {
    
    weak var viewModel: StageThreeViewModel?
    
    override func setUpScene() {
        super.setUpScene()
        
        physicsWorld.contactDelegate = self
        
        for child in self.children {
            
        }
    }
}

extension StageThreeGameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        
        
    }
}
