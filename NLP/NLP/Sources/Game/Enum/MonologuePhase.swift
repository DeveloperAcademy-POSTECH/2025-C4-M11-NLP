//
//  MonologuePhase.swift
//  NLP
//
//  Created by Ted on 7/15/25.
//

import SwiftUI

protocol MonologuePhase: Hashable {
    static var lastPhase: Self { get }
    var monologue: [(String, Color)] { get }
    var previousPhase: Self? { get }
    var nextPhase: Self? { get }
    var isSystemMonologue: Bool { get }
}
