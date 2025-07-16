//
//  MonologueAction.swift
//  NLP
//
//  Created by Ted on 7/16/25.
//

struct MonologueAction: Hashable {
    var monologue: String
    var action: (() -> Void)

    static func == (lhs: MonologueAction, rhs: MonologueAction) -> Bool {
        lhs.monologue == rhs.monologue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(monologue)
    }
}
