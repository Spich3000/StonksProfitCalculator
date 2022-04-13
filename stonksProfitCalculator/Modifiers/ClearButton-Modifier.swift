//
//  ClearButton-Modifier.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 22.03.2022.
//

import SwiftUI

struct ClearButton: ViewModifier {
        func body(content: Content) -> some View {
        content
            .frame(width: 80.0, height: 25.0)
            .cornerRadius(10)
            .foregroundColor(.black)
            .background(
                Color.gray
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.5), radius: 10,
                            x: 0.0,
                            y: 10)
            ) .opacity(0.85)
    }
}

extension View {
    var clearButton: some View {
        modifier(ClearButton())
    }
}
