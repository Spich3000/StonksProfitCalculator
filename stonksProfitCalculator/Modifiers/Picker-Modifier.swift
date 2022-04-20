//
//  Picker-Modifier.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 28.03.2022.
//

import SwiftUI

func PickerViewModifier() {
    UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color("selectedPicker"))
    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color("tabGray"))], for: .selected)
    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.gray)], for: .normal)
}

struct PickerModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .pickerStyle(SegmentedPickerStyle())
//            .shadow(color: Color("tabGray").opacity(0.3), radius: 10, x: 4, y: 4)
//            .shadow(color: Color("topWhite").opacity(1), radius: 10, x: -5, y: -5)
    }
}

extension View {
    var pickerModifier: some View {
        modifier(PickerModifier())
    }
}
