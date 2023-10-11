//
//  CircleButton.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 10/11/23.
//

import SwiftUI

enum CircleButtonIcon: String {
    case settings = "gear"
    case sellPrice = "dollarsign.circle"
    case difference = "align.vertical.bottom"
    case reload = "arrow.triangle.2.circlepath"
    case edit = "plus"
}

struct CircleButton: View {
    
    var icon: CircleButtonIcon = .edit
    var action: () -> Void
    
    var body: some View {
            Button {
                action()
            } label: {
                Image(systemName: icon.rawValue)
                    .frame(width: 24, height: 24)
                    .foregroundColor(.primary)
            }
            .buttonStyle(SimpleButtonStyle(isCircle: true))
    }
}

struct CircleButton_Previews: PreviewProvider {
    static var previews: some View {
        CircleButton() {}
    }
}
