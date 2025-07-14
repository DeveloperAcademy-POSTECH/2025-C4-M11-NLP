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
}

extension JoyStick {
    func resetJoystick() {
        self.joystickKnob.run(SKAction.move(to: self.joystickBase.position, duration: 0.1))
        self.joystickVector = .zero
        self.isTracking = false
    }
    
    // MARK: - 조이스틱 UI 생성
    func setupJoystick(camera: SKCameraNode, position: CGPoint) {
        let radius: CGFloat = 100
        
        
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
        return self.joystickBase.contains(touchLocation)
    }
    
    func startMove(_ touchLocation: CGPoint) {
        self.isTracking = true
        self.joystickKnob.position = self.joystickBase.position // 초기화
        let dx = touchLocation.x - self.joystickBase.position.x
        let dy = touchLocation.y - self.joystickBase.position.y
        let distance = sqrt(dx * dx + dy * dy)
        let maxDistance: CGFloat = 80

        if distance <= maxDistance {
            self.joystickKnob.position = CGPoint(
                x: self.joystickBase.position.x + dx,
                y: self.joystickBase.position.y + dy
            )
        } else {
            let angle = atan2(dy, dx)
            let x = cos(angle) * maxDistance
            let y = sin(angle) * maxDistance
            self.joystickKnob.position = CGPoint(
                x: self.joystickBase.position.x + x,
                y: self.joystickBase.position.y + y
            )
        }

        // 정규화된 벡터 계산
        let vector = CGVector(
            dx: self.joystickKnob.position.x - self.joystickBase.position.x,
            dy: self.joystickKnob.position.y - self.joystickBase.position.y
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
}
