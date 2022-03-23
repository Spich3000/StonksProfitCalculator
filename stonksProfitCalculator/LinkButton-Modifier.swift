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
            .background(.gray)
            .cornerRadius(10)
            .shadow(radius: 2)
    }
}

extension View {
    var linkButton: some View {
        modifier(LinkButton_Modifier())
    }
}
