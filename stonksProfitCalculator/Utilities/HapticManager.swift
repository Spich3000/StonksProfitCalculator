//
//  HapticManager.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 19.08.2022.
//

import Foundation
import SwiftUI

class HapticManager {
    static let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
