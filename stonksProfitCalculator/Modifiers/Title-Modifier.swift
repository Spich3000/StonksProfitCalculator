//
//  Title-Modifier.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 22.03.2022.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .accentColor(.gray)
            .cornerRadius(7)
//            .colorInvert()
            .padding(.horizontal, 20.0)
            .shadow(radius: 3)
            .keyboardType(.decimalPad)
    }
}

extension View {
    var title: some View {
        modifier(Title())
    }
}
