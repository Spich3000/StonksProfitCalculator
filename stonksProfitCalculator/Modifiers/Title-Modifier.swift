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
            .background(.white)
            .cornerRadius(7)
            .textFieldStyle(RoundedBorderTextFieldStyle())
//            .colorInvert()
            .accentColor(.gray)
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
