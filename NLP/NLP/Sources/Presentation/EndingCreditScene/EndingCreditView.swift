//
//  EndingCreditView.swift
//  NLP
//
//  Created by Ted on 7/25/25.
//

import SwiftUI

struct EndingCreditView: View {
    var creditNames: [String] = ["Air", "Go", "Nyx", "Mingky", "Ted", "Wonjun"]
    @State var isTransitioning: Bool = true
    @State var isTheEndShown: Bool = false
    @State var isEndingCreditShown: Bool = false
    
    @ObservedObject var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        ZStack {
            Image("StartGameImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            Text("The End")
                .font(NLPFont.headline)
                .foregroundStyle(.white)
                .opacity(isTheEndShown ? 1 : 0)
                .animation(.linear(duration: 1), value: isTheEndShown)
            
            
            CreditView(creditNames: creditNames)
                .opacity(isEndingCreditShown ? 1 : 0)
                .animation(.linear(duration: 2), value: isEndingCreditShown)
        }
        .ignoresSafeArea()
        .background(.blue)
        .onAppear {
            isTransitioning = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isTheEndShown = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isTheEndShown = false
                isEndingCreditShown = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 9) {
                coordinator.popAll()
                coordinator.push(.startGameScene)
            }
        }
    }
}

#Preview {
    EndingCreditView(coordinator: Coordinator())
}
