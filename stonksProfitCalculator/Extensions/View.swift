//
//  View.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 12.03.2023.
//

import SwiftUI

extension View {
     var background: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color("backgroundWhite"), Color("backgroundGray")]),
            startPoint: UnitPoint(x: 0.2, y: 0.2),
            endPoint: .bottomTrailing)
        .ignoresSafeArea()
    }
    
    func flashing(isFlashing: Binding<Bool>) -> some View {
        self.modifier(FlashingModifier(isFlashing: isFlashing))
    }
}
