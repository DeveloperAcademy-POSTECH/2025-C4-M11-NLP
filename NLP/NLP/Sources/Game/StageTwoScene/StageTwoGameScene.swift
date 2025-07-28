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
    var noteThree: NoteSpriteThree?
    weak var viewModel: StageTwoViewModel?
    
    override func setUpScene() {
        super.setUpScene()
        
        physicsWorld.contactDelegate = self
        print("StageTwoGameScene setUpScene 시작")
        print("총 자식 노드 수: \(self.children.count)")
        
        for (index, child) in self.children.enumerated() {
            print("자식 노드 \(index): \(type(of: child)), 이름: \(child.name ?? "nil")")
            
            if let robot = child as? RobotSprite {
                robot.configurePhysics()
                self.robot = robot
                self.originalRobotPosition = robot.position
                print("RobotSprite 설정 완료")
            } else if let pda = child as? PDASprite {
                self.pda = pda
                print("PDASprite 설정 완료")
            } else if let noteThree = child as? NoteSpriteThree {
                print("NoteSpriteThree 발견됨 - 위치: \(noteThree.position)")
                noteThree.configurePhysics()
                self.noteThree = noteThree
                print("NoteSpriteThree 설정 완료 - PhysicsBody: \(noteThree.physicsBody != nil)")
                if let physicsBody = noteThree.physicsBody {
                    print("NoteSpriteThree PhysicsBody - categoryBitMask: \(physicsBody.categoryBitMask)")
                    print("NoteSpriteThree PhysicsBody - contactTestBitMask: \(physicsBody.contactTestBitMask)")
                }
            }
        }
        print("StageTwoGameScene setUpScene 완료")
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
        
        print("충돌 감지됨: \(type(of: nodeA)) vs \(type(of: nodeB))")
        print("nodeA 이름: \(nodeA?.name ?? "nil"), nodeB 이름: \(nodeB?.name ?? "nil")")
        print("nodeA PhysicsBody categoryBitMask: \(nodeA?.physicsBody?.categoryBitMask ?? 0)")
        print("nodeB PhysicsBody categoryBitMask: \(nodeB?.physicsBody?.categoryBitMask ?? 0)")
        
        if let player = nodeA as? PlayerSprite, let robot = nodeB as? RobotSprite {
            // 충돌 액션 구현
            viewModel?.action(.robotEncountered)
        } else if let robot = nodeA as? RobotSprite, let player = nodeB as? PlayerSprite {
            // 충돌 액션 구현
            viewModel?.action(.robotEncountered)
        } else if let player = nodeA as? PlayerSprite, let noteThree = nodeB as? NoteSpriteThree {
            print("NoteSpriteThree 충돌 감지됨! (Player -> Note)")
            print("viewModel 존재 여부: \(viewModel != nil)")
            if let viewModel = viewModel {
                print("viewModel 존재함 - showNoteThreeFoundPresented 호출")
                viewModel.action(.showNoteThreeFoundPresented)
            } else {
                print("viewModel이 nil임!")
            }
        } else if let noteThree = nodeA as? NoteSpriteThree, let player = nodeB as? PlayerSprite {
            print("NoteSpriteThree 충돌 감지됨! (Note -> Player)")
            print("viewModel 존재 여부: \(viewModel != nil)")
            if let viewModel = viewModel {
                print("viewModel 존재함 - showNoteThreeFoundPresented 호출")
                viewModel.action(.showNoteThreeFoundPresented)
            } else {
                print("viewModel이 nil임!")
            }
        } else if let player = nodeA as? PlayerSprite, let _ = nodeB {
            // Player와 다른 노드 충돌 시 클래스 이름 확인
            print("Player와 충돌한 노드 클래스: \(type(of: nodeB))")
            if type(of: nodeB) == NoteSpriteThree.self {
                print("NoteSpriteThree로 인식됨!")
                if let viewModel = viewModel {
                    viewModel.action(.showNoteThreeFoundPresented)
                }
            }
        } else if let _ = nodeA, let player = nodeB as? PlayerSprite {
            // 다른 노드와 Player 충돌 시 클래스 이름 확인
            print("Player와 충돌한 노드 클래스: \(type(of: nodeA))")
            if type(of: nodeA) == NoteSpriteThree.self {
                print("NoteSpriteThree로 인식됨!")
                if let viewModel = viewModel {
                    viewModel.action(.showNoteThreeFoundPresented)
                }
            }
        } else {
            print("충돌했지만 처리되지 않은 조합: \(type(of: nodeA)) vs \(type(of: nodeB))")
            print("PhysicsCategory.noteThree.rawValue: \(PhysicsCategory.noteThree.rawValue)")
            print("PhysicsCategory.player.rawValue: \(PhysicsCategory.player.rawValue)")
        }
    }
}
