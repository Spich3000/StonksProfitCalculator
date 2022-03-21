//
//  TextClear-Modifier.swift
//  stonksProfitCalculator
//
//  Created by Nigel Gee on 20/03/2022.
//

import SwiftUI

// ClearButton modifier
fileprivate struct TitleClear: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 80.0, height: 25.0)
            .background(.gray)
            .cornerRadius(10)
    }
}

extension View {
    var titleClear: some View {
        modifier(TitleClear())
    }
}
