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
            .background(.gray)
            .cornerRadius(10)
    }
}

extension View {
    var clearButton: some View {
        modifier(ClearButton())
    }
}
