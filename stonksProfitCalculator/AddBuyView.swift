//
//  AddBuyView.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 28.03.2022.
//

import SwiftUI

struct AddBuyView: View {
    
    @State private var quantityOfTokenThirdBuy = ""
    @State private var boughtPriceThirdBuy = ""
    @State private var boughtValueThirdBuy = ""
    
    @Binding var selectInput: Int
    
    var averageTokens: Double
    var totalQuantity: Double
    
    var averageDollars: Double
    var totalAmount: Double
    
    var body: some View {
        
        ZStack{
            
            Color.yellow
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                TextField(selectInput == 0 ? "Enter amount of token: third buy" : "Enter bought value: third buy",
                          text:
                            (selectInput == 0 ? $quantityOfTokenThirdBuy : $boughtValueThirdBuy))
                    .textFieldClearButton(text:
                                            (selectInput == 0 ? $quantityOfTokenThirdBuy : $boughtValueThirdBuy))
                    .title
                
                TextField("Enter price: third buy", text: $boughtPriceThirdBuy)
                    .textFieldClearButton(text: $boughtPriceThirdBuy)
                    .title
                
                VStack(spacing: 10) {
                    Text("Your average price is:")
                        .foregroundColor(.black)
                    Text("\((selectInput == 0 ? averageTokensThird : averageDollarsThird ).formatted()) $")
                        .foregroundColor(.black)
                }
                
                Button(action: {
                    quantityOfTokenThirdBuy = ""
                    boughtPriceThirdBuy = ""
                    boughtValueThirdBuy = ""
                }) {
                    Text("Clear")
                        .clearButton
                } .shadow(radius: 2)
                
            }
        }
    }
    
    // Calculation for input 0
    var averageTokensThird: Double {
        let totalQuantity3 = totalQuantity + (Double(convert(text: quantityOfTokenThirdBuy)) ?? 0)
        let value3 = (Double(convert(text: quantityOfTokenThirdBuy)) ?? 0) * (Double(convert(text: boughtPriceThirdBuy)) ?? 0) * 1.001
        let totalValue3 = (averageTokens * totalQuantity) + value3
        let averageTokensThird = totalValue3 / totalQuantity3
        
        guard averageTokens > 0 else {return 0}
        guard Double(convert(text: quantityOfTokenThirdBuy)) ?? 0 > 0 else {return 0}
        guard Double(convert(text: boughtPriceThirdBuy)) ?? 0 > 0 else {return 0}
        return averageTokensThird
    }
    
    // Calculation for input 1
    var averageDollarsThird: Double {
        let amount3 = (Double(convert(text: boughtValueThirdBuy)) ?? 0) / (Double(convert(text: boughtPriceThirdBuy)) ?? 0)
        let totalAmount3 = totalAmount + amount3
        let totalValue3 = (averageDollars * totalAmount) + (Double(convert(text: boughtValueThirdBuy)) ?? 0)
        let averageDollarsThird = totalValue3 / totalAmount3 * 1.001
        
        guard averageDollars > 0 else {return 0}
        guard Double(convert(text: boughtValueThirdBuy)) ?? 0 > 0 else {return 0}
        guard Double(convert(text: boughtPriceThirdBuy)) ?? 0 > 0 else {return 0}
        return averageDollarsThird
    }
}
