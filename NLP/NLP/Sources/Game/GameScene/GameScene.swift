import SwiftUI
import SpriteKit

class GameScene: SKScene {
    var player: PlayerSprite?
    var touchLocation: CGPoint?
    var playerPhysicsType: PlayerPhysicsType = .normal
    var joyStick = JoyStick()
    var isJoystickTouchActive: Bool = false

    // MARK: 매 프레임마다 호출. scene.isPaused == false 여야 호출됨.
    override func update(_ currentTime: TimeInterval) {
        if self.joyStick.isTracking, let player {
            player.movePlayer(self.joyStick.getJoyStickMoveVector())
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let camera = self.camera else { return }
        guard let touchLocation = touches.first?.location(in: camera) else { return }
        
        if self.joyStick.isJoyStickAvailableLocation(touchLocation) {
            isJoystickTouchActive = true
            self.joyStick.startMove(touchLocation)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let camera = self.camera else { return }
        guard let touchLocation = touches.first?.location(in: camera) else { return }
        guard isJoystickTouchActive else { return }
        self.joyStick.startMove(touchLocation)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.joyStick.resetJoystick()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.joyStick.resetJoystick()
    }
    
    // SpriteKit 내부에서 물리 엔진 충돌/힘 등을 계산할 때 호출 (플레이어의 움직임이 있을 때 등.. 카메라의 움직임을 위해 사용하면 좋음.)
    override func didSimulatePhysics() {
        moveCamera(player?.position ?? .zero)
    }

    // MARK: Scene 이 뷰에 표시될 때 최초 한 번 호출되는 코드.
    override func didMove(to view: SKView) {
        setUpScene()
        guard let _ = player, let _ = camera else {
            fatalError(
                """
                    Game Scene: Player, Camera doesn't initiated. please initialize player, camera instance. 🙏 
                    In most cases, the issue can be resolved by calling super.setUpScene() from within your overridden setUpScene() method.
                """
            )
        }
        
        for node in self.children {
            if (node.name == NodeType.tileNodes) {
                if let someTileMap: SKTileMapNode = node as? SKTileMapNode {
                    someTileMap.giveTileMapPhysicsBody(parentScene: self)
                }
            }
        }
    }
    
    // 상속 받는 게임 Scene에서 override.
    // super.setUpScene(), 이후 필요한 노드 설정 추가.
    func setUpScene() {
        for child in self.children {
            if let sprite = child as? SKSpriteNode {
                // MARK: 픽셀 아트 선명도 유지
                sprite.texture?.filteringMode = .nearest

                if let player = child as? PlayerSprite {
                    player.configurePhysics(playerPhysicsType: self.playerPhysicsType)
                    self.player = player
                }
            } else if let cam = child as? SKCameraNode {
                scene?.camera = cam
                // MARK: 카메라의 좌표를 기준으로.
                self.joyStick.setupJoystick(
                    camera: cam,
                    position: CGPoint(
                        x: self.size.width/2 - 200,
                        y: -self.size.height/2 + 200
                    )
                )
            }
        }
    }
}

extension GameScene {
    // MARK: 사용자의 움직임 이후 사용자의 위치로 카메라를 함께 옮겨주기 위함
    private func moveCamera(_ playerLocation: CGPoint) {
        guard isJoystickTouchActive else { return }
        let stride = 0.25
        self.camera?.position.x.interpolate(
            towards: playerLocation.x,
            amount: stride
        )
        self.camera?.position.y.interpolate(
            towards: playerLocation.y,
            amount: stride
        )
    }
}

extension SKTileMapNode {
    // MARK: 타일 맵에 물리 적용, 굳이 하나하나 돌면서 하는 이유는 벽에 해당하는 노드인지 확인 후 해당 노드만 물리 적용해주기 위함.
    fileprivate func giveTileMapPhysicsBody(parentScene: SKScene) {
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
                    if tileDefinition.name != NodeType.floor {
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
