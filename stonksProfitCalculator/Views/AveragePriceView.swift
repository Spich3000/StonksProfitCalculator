//
//  AveragePriceView.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 22.03.2022.
//

import SwiftUI

struct AveragePriceView: View {
    
    // MARK: PROPERTIES
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
    
    @ObservedObject var commission: CommissionRate
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    // MARK: BODY
    var body: some View {
        ZStack {
            background
            VStack(spacing: 30) {
                pickerSection
                textFieldSection
                addBuyButton
                    .sheet(isPresented: $addBuy) {
                        AddBuyView(selectInput: $selectInput, commission: commission, averageTokens: averageTokens, totalQuantity: totalQuantity, averageDollars: averageDollars, totalAmount: totalAmount)
                    }
                VStack(spacing: 20) {
                    information.text
                    clearButton
                }
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
    
    // MARK: CALCULATIONS
    // Calculation for input "Amount of tokens"
    var totalQuantity: Double {
        (Double(convert(text: quantityOfTokenFirstBuy)) ?? Double()) + (Double(convert(text: quantityOfTokenSecondBuy)) ?? Double())
    }
    
    var averageTokens: Double {
        let value1 = (Double(convert(text: quantityOfTokenFirstBuy)) ?? 0) * (Double(convert(text: boughtPriceFirstBuy)) ?? 0)
        let value2 = (Double(convert(text: quantityOfTokenSecondBuy)) ?? 0) * (Double(convert(text: boughtPriceSecondBuy)) ?? 0)
        let totalValue = ( value1 + value2 ) * (1 + commission.commission)
        let averageTokens = totalValue / totalQuantity
        
        guard Double(convert(text: boughtPriceSecondBuy)) ?? 0 > 0 else { return 0 }
        return averageTokens
    }
    
    // Calculation for input "Bought Value"
    var totalAmount: Double {
        let amount1 = (Double(convert(text: boughtValueFirstBuy)) ?? 0) / (Double(convert(text: boughtPriceFirstBuy)) ?? 0)
        let amount2 = (Double(convert(text: boughtValueSecondBuy)) ?? 0) / (Double(convert(text: boughtPriceSecondBuy)) ?? 0)
        let totalAmount = amount1 + amount2
        return totalAmount
    }
    
    var averageDollars: Double {
        let value = (Double(convert(text: boughtValueFirstBuy)) ?? 0) + (Double(convert(text: boughtValueSecondBuy)) ?? 0)
        let averageDollars = value / totalAmount * (1 + commission.commission)
        
        guard Double(convert(text: boughtPriceSecondBuy)) ?? 0 > 0 else { return 0 }
        return averageDollars
    }
}

// MARK: PREVIEW
struct AveragePriceView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            AveragePriceView(commission: CommissionRate())
        }
    }
}

// MARK: VIEW COMPONENTS

extension AveragePriceView {
    
    private var background: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color("backgroundWhite"), Color("backgroundGray")]),
            startPoint: UnitPoint(x: 0.2, y: 0.2),
            endPoint: .bottomTrailing)
        .ignoresSafeArea()
    }
    
    private var pickerSection: some View {
        VStack {
            Text("Select input value:")
                .text
            Picker(selection: $selectInput, label: Text("Picker"), content: {
                Text("Amount of token").tag(0)
                Text("Bought Value").tag(1)
            })
            .pickerModifier
            .padding(.horizontal,20)
            .onAppear {
                PickerViewModifier()
            }
        }
    }
    
    private var textFieldSection: some View {
        VStack(spacing: 30) {
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
        }
    }
    
    private var addBuyButton: some View {
        Button(action: {
            self.addBuy.toggle()
        }) {
            HStack {
                Image(systemName: "plus")
                Text("Add buy")
            }
        }
        .buttonStyle(SimpleButtonStyle())
    }
    
    private var information: some View {
        VStack(spacing: 5) {
            Text("Your average price is:")
            Text("\((selectInput == 0 ? averageTokens : averageDollars ).formatted()) $")
        }
    }
    
    private var clearButton: some View {
        Button(action: {
            quantityOfTokenFirstBuy = ""
            boughtPriceFirstBuy = ""
            boughtValueFirstBuy = ""
            quantityOfTokenSecondBuy = ""
            boughtPriceSecondBuy = ""
            boughtValueSecondBuy = ""
        }) {
            Text("Clear")
        }
        .buttonStyle(SimpleButtonStyle())
    }
    
}
