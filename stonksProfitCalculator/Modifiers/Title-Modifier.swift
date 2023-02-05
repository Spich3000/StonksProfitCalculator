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
            .padding(.leading)
            .padding(.vertical, 12)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color("whiteBlack"), lineWidth: 3)
                    .blur(radius: 2)
                    .offset(x: -2, y: -2)
                    .mask(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(LinearGradient(Color.clear, Color.black))
                            .cornerRadius(20)
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color("grayBlack"), lineWidth: 3)
                    .blur(radius: 2)
                    .offset(x: 2, y: 2)
                    .mask(
                        RoundedRectangle(cornerRadius: 20)
                        .fill(LinearGradient(Color.black, Color.clear))
                    )
            )
            .padding(.horizontal, 20.0)
            .keyboardType(.decimalPad)
    }
}

extension View {
    var title: some View {
        modifier(Title())
    }
}

