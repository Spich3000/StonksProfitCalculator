//
//  Title-Modifier.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 22.03.2022.
//

import SwiftUI

struct Title: ViewModifier {
    
    var isSearchBar: Bool = false
    
    func body(content: Content) -> some View {
        content
            .padding(.leading)
            .padding(.vertical, 12)
            .background(
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
            .background(
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
            .keyboardType(isSearchBar ? .default : .decimalPad)
    }
}

extension View {
    var textFieldModifier: some View {
        modifier(Title())
    }
    
    var searchModifier: some View {
        modifier(Title(isSearchBar: true))
    }
}

