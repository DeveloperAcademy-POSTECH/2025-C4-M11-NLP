//
//  JoyStickNode.swift
//  SpriteKitExample
//
//  Created by 한건희 on 7/9/25.
//

import SpriteKit

class JoyStick {
    var joystickBase: SKShapeNode!
    var joystickKnob: SKShapeNode!
    var joystickVector: CGVector = .zero
    var isTracking = false
    private var defaultPosition: CGPoint = .zero
    private var isDynamicMode = false
}

extension JoyStick {
    func resetJoystick() {
        // joystickKnob이 nil인 경우 안전하게 처리
        guard let knob = self.joystickKnob else { return }
        knob.run(SKAction.move(to: self.joystickBase.position, duration: 0.1))
        self.joystickVector = .zero
        self.isTracking = false
    }
    
    // MARK: - 조이스틱 UI 생성
    func setupJoystick(camera: SKCameraNode, position: CGPoint) {
        defaultPosition = position
        createJoystickAtPosition(position, camera: camera)
    }
    
    // MARK: - 동적 조이스틱 생성
    func createDynamicJoystick(at position: CGPoint, camera: SKCameraNode) {
        // 기존 조이스틱 제거
        removeJoystick()
        
        // 새로운 위치에 조이스틱 생성
        createJoystickAtPosition(position, camera: camera)
        isDynamicMode = true
    }
    
    // MARK: - 기본 위치로 조이스틱 복원
    func restoreDefaultJoystick(camera: SKCameraNode) {
        // 기존 조이스틱 제거
        removeJoystick()
        
        // 기본 위치에 조이스틱 생성
        createJoystickAtPosition(defaultPosition, camera: camera)
        isDynamicMode = false
    }
    
    // MARK: - 조이스틱 제거
    func removeJoystick() {
        joystickBase?.removeFromParent()
        joystickKnob?.removeFromParent()
        joystickBase = nil
        joystickKnob = nil
        isTracking = false
        joystickVector = .zero
    }
    
    // MARK: - 조이스틱 생성 헬퍼 메서드
    private func createJoystickAtPosition(_ position: CGPoint, camera: SKCameraNode) {
        let radius: CGFloat = ConstantValues.joystickRadius
        
        self.joystickBase = SKShapeNode(circleOfRadius: radius)
        self.joystickBase.fillColor = .gray
        self.joystickBase.alpha = 0.2
        self.joystickBase.zPosition = 1000
        self.joystickBase.position = position

        self.joystickKnob = SKShapeNode(circleOfRadius: 25)
        self.joystickKnob.fillColor = .white
        self.joystickKnob.alpha = 0.4
        self.joystickKnob.zPosition = 1001
        self.joystickKnob.position = self.joystickBase.position

        camera.addChild(self.joystickBase)
        camera.addChild(self.joystickKnob)
    }
    
    func isJoyStickAvailableLocation(_ touchLocation: CGPoint) -> Bool {
        guard let base = self.joystickBase else { return false }
        return base.contains(touchLocation)
    }
    
    func startMove(_ touchLocation: CGPoint) {
        // 조이스틱이 존재하지 않는 경우 처리하지 않음
        guard let knob = self.joystickKnob, let base = self.joystickBase else { return }
        
        self.isTracking = true
        knob.position = base.position // 초기화
        let dx = touchLocation.x - base.position.x
        let dy = touchLocation.y - base.position.y
        let distance = sqrt(dx * dx + dy * dy)
        let maxDistance: CGFloat = 80

        if distance <= maxDistance {
            knob.position = CGPoint(
                x: base.position.x + dx,
                y: base.position.y + dy
            )
        } else {
            let angle = atan2(dy, dx)
            let x = cos(angle) * maxDistance
            let y = sin(angle) * maxDistance
            knob.position = CGPoint(
                x: base.position.x + x,
                y: base.position.y + y
            )
        }

        // 정규화된 벡터 계산
        let vector = CGVector(
            dx: knob.position.x - base.position.x,
            dy: knob.position.y - base.position.y
        )
        
        let magnitude = sqrt(vector.dx * vector.dx + vector.dy * vector.dy)
        if magnitude > 0 {
            self.joystickVector = CGVector(
                dx: vector.dx * maxDistance,
                dy: vector.dy * maxDistance
            )
        }
    }
    
    func getJoyStickMoveVector() -> CGPoint {
        return CGPoint(x: self.joystickVector.dx, y: self.joystickVector.dy)
    }
    
    func getJoystickStrength() -> CGFloat {
        guard let base = joystickBase, let knob = joystickKnob else { return 0 }
        let dx = knob.position.x - base.position.x
        let dy = knob.position.y - base.position.y
        let distance = sqrt(dx*dx + dy*dy)
        let maxDistance: CGFloat = 80 // 조이스틱 최대 거리와 동일하게
        return min(distance / maxDistance, 1.0)
    }
    
    // MARK: - 동적 모드 확인
    func isInDynamicMode() -> Bool {
        return isDynamicMode
    }
}
