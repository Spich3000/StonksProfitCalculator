//
//  SellPriceView.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 22.03.2022.
//

import SwiftUI

struct SellPriceView: View {
    
    @State private var quantityOfToken = ""
    @State private var boughtPrice = ""
    @State private var iWantPercentage = ""
    
    @ObservedObject var commission: CommissionRate
        
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
                VStack(spacing: 30) {
                    TextField("Enter quantity of token", text: $quantityOfToken)
                        .textFieldClearButton(text: $quantityOfToken)
                        .title
                    TextField("Enter bought price", text: $boughtPrice)
                        .textFieldClearButton(text: $boughtPrice)
                        .title
                    TextField("Enter profit you want to receive %", text: $iWantPercentage)
                        .textFieldClearButton(text: $iWantPercentage)
                        .title
                }
                
                VStack(spacing: 20) {
                    VStack(spacing: 15) {
                        VStack(spacing: 5) {
                            Text("Your bought value:")
                            Text("\(boughtValue, specifier: "%.2f") $")
                        }
                        VStack(spacing: 5) {
                            Text("Set limit order at:")
                            Text("\((sellPrice).formatted()) $")
                        }
                        VStack(spacing: 5) {
                            Text("Your profit:")
                            Text("\(profitValue, specifier: "%.2f") $")
                        }
                    } //Vstack TextFields
                    .text
                    Button(action: {
                        quantityOfToken = ""
                        boughtPrice = ""
                        iWantPercentage = ""
                    }) {
                        Text("Clear")
                    }
                    .buttonStyle(SimpleButtonStyle())
                } //VStack View
            }
        } .preferredColorScheme(isDarkMode ? .dark : .light)
    } 
    
    // Calculation
    
    var boughtValue: Double {
        ((Double(convert(text: quantityOfToken)) ?? 0) * (Double(convert(text: boughtPrice)) ?? 0) * (1 + commission.commission))
    }
    var sellPrice: Double {
        ((Double(convert(text: boughtPrice)) ?? 0) * ((1 + (Double(convert(text: iWantPercentage)) ?? 0) / 100) + (commission.commission)))
    }
    var sellValue: Double {
        (Double(convert(text: quantityOfToken)) ?? 0) * sellPrice
    }
    var profitValue: Double {
        guard Double(convert(text: iWantPercentage)) ?? 0 > 0 else { return 0 }
        return sellValue - boughtValue
    }
}

struct SellPriceView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            SellPriceView(commission: CommissionRate())
        }
    }
}
