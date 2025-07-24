import SwiftUI
import SpriteKit

class GameScene: SKScene {
    var player: PlayerSprite?
    var touchLocation: CGPoint?
    var playerPhysicsType: PlayerPhysicsType = .normal
    var joyStick = JoyStick()
    var isJoystickTouchActive: Bool = false

    // 햅틱 트리거 함수
    func triggerHaptic() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }

    // MARK: 매 프레임마다 호출. scene.isPaused == false 여야 호출됨.
    override func update(_ currentTime: TimeInterval) {
        if self.joyStick.isTracking, let player {
            let moveVector = self.joyStick.getJoyStickMoveVector()
            let strength = self.joyStick.getJoystickStrength()
            let maxSpeed = ConstantValues.playerMaxSpeed
            let norm = sqrt(moveVector.x * moveVector.x + moveVector.y * moveVector.y)
            let direction = norm > 0 ? CGVector(dx: moveVector.x / norm, dy: moveVector.y / norm) : .zero
            player.movePlayer(direction: direction, strength: strength, maxSpeed: maxSpeed)
            triggerHaptic() // 조이스틱이 생성되어 있고, 터치가 유지되는 동안 계속 진동
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
        guard let camera = self.camera else { return }
        guard let touchLocation = touches.first?.location(in: camera) else { return }
        guard isJoystickTouchActive else { return }
        self.joyStick.startMove(touchLocation)
        // 진동은 update에서 처리
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 조이스틱이 존재하는 경우에만 reset 호출
        if self.joyStick.joystickKnob != nil {
        self.joyStick.resetJoystick()
        }
        isJoystickTouchActive = false
        
        // 터치가 끝나면 조이스틱 제거
        self.joyStick.removeJoystick()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 조이스틱이 존재하는 경우에만 reset 호출
        if self.joyStick.joystickKnob != nil {
        self.joyStick.resetJoystick()
        }
        isJoystickTouchActive = false
        
        // 터치가 취소되면 조이스틱 제거
        self.joyStick.removeJoystick()
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
            if (node.name == ConstantNodes.tileNodes) {
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
                // MARK: 기본 조이스틱 설정 제거 - 터치할 때만 생성됨
            }
        }
    }
}

extension GameScene {
    // MARK: 사용자의 움직임 이후 사용자의 위치로 카메라를 함께 옮겨주기 위함
    private func moveCamera(_ playerLocation: CGPoint) {
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


