//
//  InputView.swift
//  stonksProfitCalculator
//
//  Created by Nigel Gee on 20/03/2022.
//

import SwiftUI

struct SellPriceView: View {
    @FocusState private var focus: Bool
    
    @State private var quantityOfToken = ""
    @State private var boughtPrice = ""
    @State private var iWantPercentage = ""
    
    var body: some View {
        ZStack {
            Color.yellow
                .ignoresSafeArea()

            VStack {

                TextField("Enter quantity of token", text: $quantityOfToken)
                    .textFieldClearButton(text: $quantityOfToken)
                    .title
                    .focused($focus)

                TextField("Enter bought price", text: $boughtPrice)
                    .textFieldClearButton(text: $boughtPrice)
                    .title
                    .focused($focus)

                TextField("Enter profit you want to receive %", text: $iWantPercentage)
                    .textFieldClearButton(text: $iWantPercentage)
                    .title
                    .focused($focus)

                Text("Your bought value:")
                    .foregroundColor(.black)
                    .padding(.bottom, -20)

                Text("\(boughtValue, specifier: "%.2f")$")
                    .foregroundColor(.black)
                    .padding()

                Text("Set limit order at:")
                    .foregroundColor(.black)
                    .padding(.bottom, -20)

                Text("\((sellPrice).formatted())$")
                    .foregroundColor(.black)
                    .padding()

                Text("Your profit:")
                    .foregroundColor(.black)
                    .padding(.bottom, -20)

                Text("\(profitValue, specifier: "%.2f")$")
                    .foregroundColor(.black)
                    .padding()

            }

            Button {
                quantityOfToken = ""
                boughtPrice = ""
                iWantPercentage = ""
            } label: {
                Text("Clear")
                    .titleClear
            }
            .padding(.top, 500.0)
            .shadow(radius: 2)
        }
    }

    var boughtValue: Double {
        ((Double(convert(text: quantityOfToken)) ?? 0) * (Double(convert(text: boughtPrice)) ?? 0) * 1.001)
    }

    var sellPrice: Double {
        ((Double(convert(text: boughtPrice)) ?? 0) * ((1 + (Double(convert(text: iWantPercentage)) ?? 0) / 100) + 0.001))
    }

    var sellValue: Double {
        (Double(convert(text: quantityOfToken)) ?? 0) * sellPrice
    }

    var profitValue: Double {
        sellValue - boughtValue
    }

    // Replace "," with "." function
    func convert(text: String) -> String {
         text.replacingOccurrences(of: ",", with: ".")
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        SellPriceView()
    }
}
