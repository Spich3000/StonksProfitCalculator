//
//  Text-Modifier.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 18.04.2022.
//

import SwiftUI

struct TextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color("tabGray"))
//            .shadow(color: Color("tabGray").opacity(0.3), radius: 10, x: 5, y: 5)
//            .shadow(color: Color("topWhite").opacity(0.7), radius: 10, x: -5, y: -5)
    }
}

extension View {
    var text: some View {
        modifier(TextModifier())
    }
}
