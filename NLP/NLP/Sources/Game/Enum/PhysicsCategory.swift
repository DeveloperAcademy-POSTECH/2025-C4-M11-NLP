//
//  PhysicsCategory.swift
//  SpriteKitExample
//
//  Created by 한건희 on 7/8/25.
//

// 물리 카테고리 정의, SpriteKit의 충돌, 접촉 시스템은 categoryBitMask, contactTestBitMask, collisionBitMask 를 통해 어떤 객체들이 서로 충돌하거나 접촉할지 비트 연산으로 처리되기 때문에 비트 마스크로 표현함.
enum PhysicsCategory: UInt32 {
    case none = 0
    case wall = 0b1 // 1
    case player = 0b10 // 2
    case box = 0b100 // 4
    case computer = 0b1000 // 8
}
