//
//  DifferenceView.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 22.03.2022.
//

import SwiftUI

struct DifferenceView: View {
    
    @State private var sellValue = ""
    @State private var boughtValue = ""
    
    var body: some View {
        
        ZStack {
            
            Color.yellow
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                TextField("Enter sell value", text: $sellValue)
                    .textFieldClearButton(text: $sellValue)
                    .title
                
                TextField("Enter bought value", text: $boughtValue)
                    .textFieldClearButton(text: $boughtValue)
                    .title
                
                VStack(spacing: 20) {
                    VStack(spacing: 5) {
                    Text("Difference is:")
                        .foregroundColor(.black)
                    Text("\(percentageDifference, specifier: "%.2f") %")
                        .foregroundColor(.black)
                    }
                Button(action: {
                    sellValue = ""
                    boughtValue = ""
                }) {
                    Text("Clear")
                        .clearButton
                } //.shadow(radius: 2)
                } .blockView
                    .padding(.horizontal, 20)

            }
        }
    }
    // Difference calculation
    var percentageDifference: Double {
        guard Double(convert(text: boughtValue)) ?? 0 > 0 else { return 0 }
        return ((Double(convert(text: sellValue)) ?? 0) - (Double(convert(text: boughtValue)) ?? 0)) / (Double(convert(text: boughtValue)) ?? 100) * 100
    }
}

struct DifferenceView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            DifferenceView()
        }
    }
}
