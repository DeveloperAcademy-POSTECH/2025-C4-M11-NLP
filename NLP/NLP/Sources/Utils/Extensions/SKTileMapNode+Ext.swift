//
//  SKTileMapNode+Ext.swift
//  NLP
//
//  Created by Ted on 7/14/25.
//

import SpriteKit

extension SKTileMapNode {
    // MARK: 타일 맵에 물리 적용, 굳이 하나하나 돌면서 하는 이유는 벽에 해당하는 노드인지 확인 후 해당 노드만 물리 적용해주기 위함.
    func giveTileMapPhysicsBody(parentScene: SKScene) {
        let tileMap = self
        let startLocation: CGPoint = tileMap.position
        let tileSize = tileMap.tileSize
        let halfWidth = CGFloat(tileMap.numberOfColumns) / 2.0 * tileSize.width
        let halfHeight = CGFloat(tileMap.numberOfRows) / 2.0 * tileSize.height

        for col in 0..<tileMap.numberOfColumns {
            for row in 0..<tileMap.numberOfRows {
                if let tileDefinition = tileMap.tileDefinition(atColumn: col, row: row) {
                    let tileArray = tileDefinition.textures
                    let tileTextures = tileArray[0]
                    let x = CGFloat(col) * tileSize.width - halfWidth + (tileSize.width / 2)
                    let y = CGFloat(row) * tileSize.height - halfHeight + (tileSize.height / 2)

                    let tileNode = SKSpriteNode(texture: tileTextures)
                    tileNode.position = CGPoint(x: x, y: y)
                    tileNode.size = CGSize(width: ConstantValues.mapBlockSize, height: ConstantValues.mapBlockSize)
                    tileNode.texture?.filteringMode = .nearest
                    
                    // 플레이어 - 벽 충돌 활성화
                    if tileDefinition.name != ConstantNodes.floor {
                        tileNode.physicsBody = SKPhysicsBody(
                            texture: tileTextures,
                            size: tileNode.size
                        )
                        tileNode.physicsBody?.usesPreciseCollisionDetection = true
                        tileNode.physicsBody?.categoryBitMask = PhysicsCategory.wall.rawValue
                        tileNode.physicsBody?.contactTestBitMask = PhysicsCategory.player.rawValue | PhysicsCategory.box.rawValue
                        tileNode.physicsBody?.collisionBitMask = PhysicsCategory.player.rawValue | PhysicsCategory.box.rawValue
                        tileNode.physicsBody?.affectedByGravity = false
                        tileNode.physicsBody?.isDynamic = false
                        tileNode.physicsBody?.friction = 1
                    }
                    
                    tileNode.zPosition = -1

                    tileNode.position = CGPoint(
                        x: tileNode.position.x + startLocation.x,
                        y: tileNode.position.y + startLocation.y
                    )
                    parentScene.addChild(tileNode)
                }
            }
        }
        self.removeFromParent()
    }
}
