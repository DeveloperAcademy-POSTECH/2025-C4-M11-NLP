//
//  MonologuePhase.swift
//  NLP
//
//  Created by Ted on 7/15/25.
//

protocol MonologuePhase: Hashable {
    static var lastPhase: Self { get }
    var monologue: String { get }
    var previousPhase: Self? { get }
    var nextPhase: Self? { get }
}
