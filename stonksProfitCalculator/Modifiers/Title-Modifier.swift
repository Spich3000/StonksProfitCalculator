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
            .padding(.vertical, 8)
            .overlay(
                Rectangle()
                    .stroke(Color("whiteBlack"), lineWidth: 2)
                    .blur(radius: 2)
                    .offset(x: -2, y: -2)
                    .mask(Rectangle().fill(LinearGradient(Color.clear, Color.black)))
            )
            .overlay(
                Rectangle()
                    .stroke(Color("grayBlack"), lineWidth: 2)
                    .blur(radius: 2)
                    .offset(x: 2, y: 2)
                    .mask(Rectangle().fill(LinearGradient(Color.black, Color.clear)))
            )
            .cornerRadius(10)
            .padding(.horizontal, 20.0)
            .keyboardType(.decimalPad)
    }
}

extension View {
    var title: some View {
        modifier(Title())
    }
}

struct SearchBar: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.leading)
            .padding(.vertical, 8)
            .overlay(
                Rectangle()
                    .stroke(Color("whiteBlack"), lineWidth: 2)
                    .blur(radius: 2)
                    .offset(x: -2, y: -2)
                    .mask(Rectangle().fill(LinearGradient(Color.clear, Color.black)))
            )
            .overlay(
                Rectangle()
                    .stroke(Color("grayBlack"), lineWidth: 2)
                    .blur(radius: 2)
                    .offset(x: 2, y: 2)
                    .mask(Rectangle().fill(LinearGradient(Color.black, Color.clear)))
            )
            .cornerRadius(10)
            .padding(.horizontal, 20.0)
    }
}

extension View {
    var searchBar: some View {
        modifier(SearchBar())
    }
}
