//
//  Converter-Modifier.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 23.03.2022.
//
import SwiftUI

extension View {
    func convert(text: String) -> String {
        text.replacingOccurrences(of: ",", with: ".")
    }
}
