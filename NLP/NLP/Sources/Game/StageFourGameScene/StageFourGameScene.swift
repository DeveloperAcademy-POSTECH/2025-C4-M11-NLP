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
    var air: FinnSprite?
    var jane: JaneSprite?
    
    var pool: PoolSprite?
    var signalMachine: SignalMachineSprite?
    var flame: FlameSprite?
    
    
    override func setUpScene() {
        super.setUpScene()
        
        for child in self.children {
            if let robot = child as? RobotSprite {
                robot.configurePhysics()
                self.robot = robot
            } else if let air = child as? FinnSprite {
                air.configurePhysics()
                self.air = air
            } else if let jane = child as? JaneSprite {
                jane.configurePhysics()
                self.jane = jane
            } else if let pool = child as? PoolSprite {
                pool.configurePhysics()
                self.pool = pool
            } else if let signalMachine = child as? SignalMachineSprite {
                signalMachine.configurePhysics()
                self.signalMachine = signalMachine
            } else if let flame = child as? FlameSprite {
                self.flame = flame
            }
        }
        
        setCameraFocusToPool()
    }
    
    func moveRobotToPlasma() async {
        guard let pool = pool, let robot = robot else { return }
        let robotMoveAction = SKAction.move(to: pool.position, duration: 2)
        await robot.run(robotMoveAction)
    }
    
    func fleeAllExceptRobot() async {
        guard let player = player, let jane = jane, let air = air else { return }
//        let allExceptRobotMoveAction = SKAction.move(to: CGPoint(x: player.position.x - 200, y: player.position.y - 100), duration: 2)
        let allExceptRobotMoveAction = SKAction.move(by: CGVector(dx: -1000, dy: -1000), duration: 2)
        await withTaskGroup(of: Void.self) { group in
            for character in [jane, player, air].compactMap({ $0 }) {
                group.addTask {
                    await character.run(allExceptRobotMoveAction)
                }
            }
        }
    }
    
    func explode() async {
        guard let flame = flame else { return }
        flame.size = CGSize(width: 600, height: 600)
        for i in 1...6 {
            await MainActor.run {
                let image = UIImage(named: "flame\(i)")
                guard let image = image else { return }
                flame.texture = SKTexture(image: image)
            }
            try? await Task.sleep(for: .seconds(0.3))
        }
        try? await Task.sleep(for: .seconds(1))
    }
    
    
    
    func robotComeBack() async {
        guard let air = air, let robot = robot else { return }
        robot.texture = SKTexture(imageNamed: "robot-new-new")
        let move = SKAction.move(to: CGPoint(x: air.position.x + 100, y: air.position.y - 50), duration: 2)
        await robot.run(move)
    }
    
    func setCameraFocusToAir() {
        cameraFocusedNode = air
    }
    
    func setCameraFocusToPool() {
        cameraFocusedNode = pool
    }
}
