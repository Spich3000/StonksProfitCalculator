//
//  CircleButton.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 10/11/23.
//

import SwiftUI

enum CircleButtonIcon: String {
    case settings = "gearshape"
    case sellPrice = "dollarsign.circle"
    case difference = "align.vertical.bottom"
    case reload = "arrow.triangle.2.circlepath"
    case edit = "plus"
}

struct CircleButton: View {
    
    @State private var rotation: CGFloat = 0
        
    var icon: CircleButtonIcon = .edit
    var isRotationNeeded: Bool = false
    var action: () -> Void
    
    var body: some View {
            Button {
                action()
                if isRotationNeeded {
                    withAnimation(.easeInOut(duration: 1)) {
                        rotation = 360
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        rotation = 0
                    }
                }
            } label: {
                Image(systemName: icon.rawValue)
                    .frame(width: 25, height: 25)
                    .foregroundColor(.primary)
                    .rotationEffect(Angle(degrees: rotation), anchor: .center)
            }
            .buttonStyle(SimpleButtonStyle(isCircle: true))
    }
}

struct CircleButton_Previews: PreviewProvider {
    static var previews: some View {
        CircleButton() {}
    }
}
