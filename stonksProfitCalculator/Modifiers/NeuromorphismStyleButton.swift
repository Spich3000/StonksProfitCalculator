//
//  NeuromorphismStyleButton.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 18.04.2022.
//

import SwiftUI

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(
            gradient: Gradient(colors: colors),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
}

struct SimpleButtonStyle: ButtonStyle {
    
    var isCircle: Bool = false
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color("tabGray"))
            .padding(.horizontal, isCircle ? 10 : 20)
            .padding(.vertical, isCircle ? 10 : 5)
            .contentShape(Rectangle())
            .background(
                Group {
                    if configuration.isPressed {
                        Rectangle()
                            .fill(Color("topWhite"))
                            .overlay(
                                Rectangle()
                                    .stroke(Color("grayBlack"), lineWidth: 4)
                                    .blur(radius: 4)
                                    .offset(x: 2, y: 2)
                                    .mask(
                                        Rectangle()
                                            .fill(LinearGradient(Color("blackWhite"), Color.clear))
                                    )
                            )
                            .cornerRadius(isCircle ? 25 : 20)
                            .overlay(
                                Rectangle()
                                    .stroke(Color("whiteBlack"), lineWidth: 8)
                                    .blur(radius: 4)
                                    .offset(x: -2, y: -2)
                                    .mask(
                                        Rectangle()
                                            .fill(LinearGradient(Color.clear, Color("blackWhite")))
                                    )
                            )
                            .cornerRadius(isCircle ? 25 : 20)
                        
                    } else {
                        Rectangle()
                            .fill(Color("topWhite"))
                            .cornerRadius(isCircle ? 25 : 20)
                            .shadow(color: Color("blackWhite").opacity(0.2), radius: 10, x: 4, y: 4)
                            .shadow(color: Color("whiteBlack").opacity(1), radius: 10, x: -5, y: -5)
                        
                    }
                }
            )
    }
}
