//
//  Picker-Modifier.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 28.03.2022.
//

import SwiftUI

func PickerViewModifier() {
    UISegmentedControl.appearance().selectedSegmentTintColor = .gray
    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
}

struct PickerModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .pickerStyle(SegmentedPickerStyle())
            .shadow(color: Color.black.opacity(0.3), radius: 10,
                    x: 0.0,
                    y: 10)        
    }
}

extension View {
    var pickerModifier: some View {
        modifier(PickerModifier())
    }
}
