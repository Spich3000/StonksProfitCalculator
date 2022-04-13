//
//  AveragePriceView.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 22.03.2022.
//

import SwiftUI

struct AveragePriceView: View {
    // Variables for input 0
    @State private var quantityOfTokenFirstBuy = ""
    @State private var boughtPriceFirstBuy = ""
    @State private var boughtValueFirstBuy = ""
    // Variables for input 1
    @State private var quantityOfTokenSecondBuy = ""
    @State private var boughtPriceSecondBuy = ""
    @State private var boughtValueSecondBuy = ""
    
    @State var addBuy = false
    @State var selectInput = 0
    
    // Change picker colors
    init() {PickerViewModifier()}
    
    var body: some View {
        
        ZStack {
            
            Color.yellow
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                VStack {
                    Text("Select input value:")
                        .foregroundColor(.black)
                    
                    Picker(selection: $selectInput, label: Text("Picker"), content: {
                        Text("Amount of token").tag(0)
                        Text("Bought Value").tag(1)
                    })
                    .pickerModifier
                }  .blockView
                
                TextField(selectInput == 0 ? "Enter amount of token: first buy" : "Enter bought value: first buy",
                          text: (selectInput == 0 ? $quantityOfTokenFirstBuy : $boughtValueFirstBuy))
                .textFieldClearButton(text: (selectInput == 0 ? $quantityOfTokenFirstBuy : $boughtValueFirstBuy))
                .title
                
                TextField("Enter price: first buy", text: $boughtPriceFirstBuy)
                    .textFieldClearButton(text: $boughtPriceFirstBuy)
                    .title
                
                TextField(selectInput == 0 ? "Enter amount of token: second buy" : "Enter bought value: second buy",
                          text: (selectInput == 0 ? $quantityOfTokenSecondBuy : $boughtValueSecondBuy))
                .textFieldClearButton(text: (selectInput == 0 ? $quantityOfTokenSecondBuy : $boughtValueSecondBuy))
                .title
                
                TextField("Enter price: second buy", text: $boughtPriceSecondBuy)
                    .textFieldClearButton(text: $boughtPriceSecondBuy)
                    .title
                
                Button(action: {
                    self.addBuy.toggle()
                }) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add buy")
                    }
                }
                .sheet(isPresented: $addBuy) {
                    AddBuyView(selectInput: $selectInput, averageTokens: averageTokens, totalQuantity: totalQuantity, averageDollars: averageDollars, totalAmount: totalAmount)
                }
                
                VStack(spacing: 20) {
                    VStack(spacing: 5) {
                        Text("Your average price is:")
                            .foregroundColor(.black)
                        Text("\((selectInput == 0 ? averageTokens : averageDollars ).formatted()) $")
                            .foregroundColor(.black)
                    }
                    Button(action: {
                        quantityOfTokenFirstBuy = ""
                        boughtPriceFirstBuy = ""
                        boughtValueFirstBuy = ""
                        quantityOfTokenSecondBuy = ""
                        boughtPriceSecondBuy = ""
                        boughtValueSecondBuy = ""
                    }) {
                        Text("Clear")
                            .clearButton
                    }
                } .blockView
            }
        }
    }
    
    // Calculation for input 0
    var totalQuantity: Double {
        (Double(convert(text: quantityOfTokenFirstBuy)) ?? 0) + (Double(convert(text: quantityOfTokenSecondBuy)) ?? 0)
    }
    
    var averageTokens: Double {
        let value1 = (Double(convert(text: quantityOfTokenFirstBuy)) ?? 0) * (Double(convert(text: boughtPriceFirstBuy)) ?? 0)
        let value2 = (Double(convert(text: quantityOfTokenSecondBuy)) ?? 0) * (Double(convert(text: boughtPriceSecondBuy)) ?? 0)
        let totalValue = ( value1 + value2 ) * (1)
        let averageTokens = totalValue / totalQuantity
        
        guard Double(convert(text: boughtPriceSecondBuy)) ?? 0 > 0 else { return 0 }
        return averageTokens
    }
    
    // Calculation for input 1
    var totalAmount: Double {
        let amount1 = (Double(convert(text: boughtValueFirstBuy)) ?? 0) / (Double(convert(text: boughtPriceFirstBuy)) ?? 0)
        let amount2 = (Double(convert(text: boughtValueSecondBuy)) ?? 0) / (Double(convert(text: boughtPriceSecondBuy)) ?? 0)
        let totalAmount = amount1 + amount2
        return totalAmount
    }
    
    var averageDollars: Double {
        let value = (Double(convert(text: boughtValueFirstBuy)) ?? 0) + (Double(convert(text: boughtValueSecondBuy)) ?? 0)
        let averageDollars = value / totalAmount * (1)
        
        guard Double(convert(text: boughtPriceSecondBuy)) ?? 0 > 0 else { return 0 }
        return averageDollars
    }
}


struct AveragePriceView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            AveragePriceView()
        }
    }
}
