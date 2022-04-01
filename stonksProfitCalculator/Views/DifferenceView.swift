//
//  DifferenceView.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 22.03.2022.
//

import SwiftUI

struct DifferenceView: View {
    
    @State private var sellValue2 = ""
    @State private var boughtValue2 = ""
    
    var body: some View {
        
        ZStack {
            
            Color.yellow
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                TextField("Enter sell value", text: $sellValue2)
                    .textFieldClearButton(text: $sellValue2)
                    .title
                
                TextField("Enter bought value", text: $boughtValue2)
                    .textFieldClearButton(text: $boughtValue2)
                    .title
                
                VStack(spacing: 10) {
                    Text("Difference is:")
                        .foregroundColor(.black)
                    Text("\(percentageDifference, specifier: "%.2f") %")
                        .foregroundColor(.black)
                }
                
                Button(action: {
                    sellValue2 = ""
                    boughtValue2 = ""
                }) {
                    Text("Clear")
                        .clearButton
                } .shadow(radius: 2)
            }
        }
    }
    // Difference calculation
    var percentageDifference: Double {
        guard Double(convert(text: boughtValue2)) ?? 0 > 0 else { return 0 }
        return ((Double(convert(text: sellValue2)) ?? 0) - (Double(convert(text: boughtValue2)) ?? 0)) / (Double(convert(text: boughtValue2)) ?? 100) * 100
    }
}

struct DifferenceView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            DifferenceView()
        }
    }
}
