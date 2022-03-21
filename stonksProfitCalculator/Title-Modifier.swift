//
//  Title-Modifier.swift
//  stonksProfitCalculator
//
//  Created by Nigel Gee on 20/03/2022.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .colorInvert()
            .accentColor(.gray)
            .padding(.horizontal, 35.0)
            .padding(.bottom, 20.0)
            .shadow(radius: 2)
            .keyboardType(.decimalPad)
    }
}

extension View {
    var title: some View {
        modifier(Title())
    }
}
