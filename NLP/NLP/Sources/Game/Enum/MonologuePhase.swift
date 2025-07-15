//
//  MonologuePhase.swift
//  NLP
//
//  Created by Ted on 7/15/25.
//

protocol MonologuePhase {
    var monologue: String { get }
    var previousPhase: Self? { get }
    var nextPhase: Self? { get }
    var buttonTexts: [String] { get }
    var isNextButtonActionEnabled: Bool { get }
}
