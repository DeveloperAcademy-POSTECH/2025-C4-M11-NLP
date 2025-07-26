//
//  CreditView.swift
//  NLP
//
//  Created by Ted on 7/26/25.
//

import SwiftUI

struct CreditView: View {
    var creditNames: [String]
    
    var body: some View {
        VStack {
            Spacer().frame(height: 100)
            Text("Credits")
                .font(NLPFont.headline)
                .foregroundStyle(.white)
            Spacer()
            ForEach(creditNames, id: \.self) { name in
                Text(name)
                    .font(NLPFont.body)
                    .foregroundStyle(.white)
            }
            Spacer()
        }
    }
}
