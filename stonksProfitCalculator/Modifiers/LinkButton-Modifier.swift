//
//  LinkButton-Modifier.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 22.03.2022.
//

import SwiftUI

struct LinkButton_Modifier: ViewModifier {
    func body(content: Content) -> some View {
        content
//            .background(.gray)
            .cornerRadius(10)
//            .shadow(radius: 2)
            .background(
                Color.gray
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.3), radius: 10,
                            x: 0.0,
                            y: 10)
            ) .opacity(0.85)
    }
}

extension View {
    var linkButton: some View {
        modifier(LinkButton_Modifier())
    }
}
