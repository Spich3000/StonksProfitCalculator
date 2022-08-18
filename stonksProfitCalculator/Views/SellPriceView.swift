//
//  SellPriceView.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 22.03.2022.
//

import SwiftUI

struct SellPriceView: View {
    
    // MARK: PROPERTIES
    @State private var quantityOfToken = ""
    @State private var boughtPrice = ""
    @State private var iWantPercentage = ""
    
    @ObservedObject var commission: CommissionRate
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    // MARK: BODY
    var body: some View {
        ZStack {
            backgroundColor
            VStack(spacing: 30) {
                textFieldsSection
                VStack(spacing: 20) {
                    information.text
                    clearButton
                }
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
    
    // MARK: CALCULATIONS
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

// MARK: PREVIEW
struct SellPriceView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            SellPriceView(commission: CommissionRate())
        }
    }
}

// MARK: VIEW COMPONENTS
extension SellPriceView {
    private var backgroundColor: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color("backgroundWhite"), Color("backgroundGray")]),
            startPoint: UnitPoint(x: 0.2, y: 0.2),
            endPoint: .bottomTrailing)
        .ignoresSafeArea()
    }
    
    private var textFieldsSection: some View {
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
    }
    
    private var information: some View {
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
        }
    }
    
    private var clearButton: some View {
        Button(action: {
            quantityOfToken = ""
            boughtPrice = ""
            iWantPercentage = ""
        }) {
            Text("Clear")
        }
        .buttonStyle(SimpleButtonStyle())
    }
    
}
