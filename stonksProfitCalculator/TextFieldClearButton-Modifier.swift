//
//  TextFieldClearButton-Modifier.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 22.03.2022.
//

import SwiftUI

struct TextFieldClearButton: ViewModifier {
    
    @Binding var text: String
    
    func body(content: Content) -> some View {
        
        ZStack(alignment: .trailing) {
            
            content
            
            if !text.isEmpty {
                
                Button(
                    action: { self.text = "" },
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
    func textFieldClearButton(text: Binding<String>) -> some View {
        modifier(TextFieldClearButton(text: text))
    }
}
