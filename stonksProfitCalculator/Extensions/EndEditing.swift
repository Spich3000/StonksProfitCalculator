//
//  EndEditing.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 18.08.2022.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
