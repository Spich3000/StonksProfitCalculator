//
//  TextFieldClearButton.swift
//  stonksProfitCalculator
//
//  Created by Nigel Gee on 20/03/2022.
//

import SwiftUI

fileprivate struct TextFieldClearButton: ViewModifier {
    @Binding var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {

            content

            if !text.isEmpty {

                Button(
                    action: { text = "" },
                    label: {
                        Image(systemName: "multiply.circle")
                            .padding(.trailing)
                    }
                )
            }
        }
    }
}

extension View {
    func textFieldClearButton(text: Binding<String>) -> some View {
        modifier(TextFieldClearButton(text: text))
    }
}
