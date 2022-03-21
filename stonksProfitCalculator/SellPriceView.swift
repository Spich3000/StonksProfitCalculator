//
//  InputView.swift
//  stonksProfitCalculator
//
//  Created by Nigel Gee on 20/03/2022.
//

import SwiftUI

struct SellPriceView: View {
    @FocusState private var focus: Bool
    
    @State private var quantityOfToken = 0.0
    @State private var boughtPrice = 0.0
    @State private var iWantPercentage = 0.0
    
    var body: some View {
        ZStack {
            Color.yellow
                .ignoresSafeArea()

            VStack {
                VStack(spacing: 2) {
                    Text("Enter quantity of token")
                    TextField("Enter quantity of token", value: $quantityOfToken, format: .number)
                        .textFieldClearButton(for: $quantityOfToken)
                        .title
                        .focused($focus)

                    Text("Enter bought price")
                    TextField("Enter bought price", value: $boughtPrice ,format: .number)
                        .textFieldClearButton(for: $boughtPrice)
                        .title
                        .focused($focus)

                    Text("Enter profit you want to receive %")
                    TextField("Enter profit you want to receive %", value: $iWantPercentage, format: .number)
                        .textFieldClearButton(for: $iWantPercentage)
                        .title
                        .focused($focus)
                }

                Text("Your bought value:")
                    .foregroundColor(.black)
                    .padding(.bottom, -20)

                Text("\(boughtValue, format: .currency(code: "USD"))")
                    .foregroundColor(.black)
                    .padding()

                Text("Set limit order at:")
                    .foregroundColor(.black)
                    .padding(.bottom, -20)

                Text("\((sellPrice), format: .currency(code: "USD"))")
                    .foregroundColor(.black)
                    .padding()

                Text("Your profit:")
                    .foregroundColor(.black)
                    .padding(.bottom, -20)

                Text("\(profitValue, format: .currency(code: "USD"))")
                    .foregroundColor(.black)
                    .padding()

            }

            Button {
                quantityOfToken = 0.0
                boughtPrice = 0.0
                iWantPercentage = 0.0
            } label: {
                Text("Clear")
                    .titleClear
            }
            .padding(.top, 500.0)
            .shadow(radius: 2)
        }
    }

    var boughtValue: Double {
        quantityOfToken * (boughtPrice * 1.001)
    }

    var sellPrice: Double {
        boughtPrice * ((1 + (iWantPercentage) / 100) + 0.001)
    }

    var sellValue: Double {
        quantityOfToken * sellPrice
    }

    var profitValue: Double {
        sellValue - boughtValue
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        SellPriceView()
    }
}
