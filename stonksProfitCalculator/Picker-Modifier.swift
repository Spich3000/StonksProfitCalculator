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
