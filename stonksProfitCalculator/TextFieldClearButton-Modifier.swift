//
//  TextFieldClearButton.swift
//  stonksProfitCalculator
//
//  Created by Nigel Gee on 20/03/2022.
//

import SwiftUI

fileprivate struct NumberFieldClearButton: ViewModifier {
    @Binding var number: Double

    func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {

            content

            if number != 0 {
                Button(
                    action: { number = 0.0 },
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
    func textFieldClearButton(for number: Binding<Double>) -> some View {
        modifier(NumberFieldClearButton(number: number))
    }
}
