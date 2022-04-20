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
    
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color("backgroundWhite"), Color("backgroundGray")]),
                startPoint: UnitPoint(x: 0.2, y: 0.2),
                endPoint: .bottomTrailing
            )
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
                        Text("\(percentageDifference, specifier: "%.2f") %")
                    }
                    .text
                    Button(action: {
                        sellValue = ""
                        boughtValue = ""
                    }) {
                        Text("Clear")
                    }
                    .buttonStyle(SimpleButtonStyle())
                }
            }
        } .preferredColorScheme(isDarkMode ? .dark : .light)
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
