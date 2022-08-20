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
    }
}

extension View {
    var text: some View {
        modifier(TextModifier())
    }
}
