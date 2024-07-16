//
//  FlashingModifier.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 7/15/24.
//

import SwiftUI

struct FlashingModifier: ViewModifier {
    @Binding var isFlashing: Bool

    func body(content: Content) -> some View {
        content
            .overlay(
                Circle()
                    .stroke(Color("blackWhite").opacity(0.5), lineWidth: 5)
                    .scaleEffect(isFlashing ? 1.2 : 1.0)
                    .opacity(isFlashing ? 0 : 1)
                    .animation(Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: isFlashing)
            )
    }
}
