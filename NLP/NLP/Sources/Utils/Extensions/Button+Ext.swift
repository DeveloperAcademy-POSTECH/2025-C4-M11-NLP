//
//  Button+Ext.swift
//  NLP
//
//  Created by Ted on 7/24/25.
//
import SwiftUI

extension Button {
    init(
        isClickSoundAvailable: Bool,
        action: @escaping @MainActor () -> Void,
        @ViewBuilder label: () -> Label
    ) {
        self.init(
            action: {
                action()
                Task { await MusicManager.shared.playClickSound() }
            },
            label: label
        )
    }
}
