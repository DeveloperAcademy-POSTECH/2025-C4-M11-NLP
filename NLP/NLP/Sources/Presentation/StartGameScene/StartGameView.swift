//
//  StartGameView.swift
//  NLP
//
//  Created by Ted on 7/14/25.
//

import SwiftUI

struct StartGameView: View {
    @StateObject var viewModel: StartGameViewModel
    
    init(coordinator: Coordinator) {
        self._viewModel = StateObject(wrappedValue: StartGameViewModel(coordinator: coordinator))
    }
    
    var body: some View {
        Text("StartGameView")
            .onTapGesture {
                viewModel.action(.textTapped)
            }
    }
}
