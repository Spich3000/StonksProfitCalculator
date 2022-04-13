//
//  BlockView-Modifier.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 12.04.2022.
//

import SwiftUI

struct BlockView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                Color(#colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1))
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.3), radius: 10,
                            x: 0.0,
                            y: 10)
            ) .opacity(0.85)
            .padding(.horizontal, 20)

    }
}

extension View {
    var blockView: some View {
        modifier(BlockView())
    }
}
