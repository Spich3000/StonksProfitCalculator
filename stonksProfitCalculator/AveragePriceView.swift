//
//  AveragePriceView.swift
//  stonksProfitCalculator
//
//  Created by Nigel Gee on 20/03/2022.
//

import SwiftUI

struct AveragePriceView: View {
    @FocusState private var focus: Bool
    
    @State private var quantityOfTokenFirstBuy = ""
    @State private var boughtPriceFirstBuy = ""
    @State private var quantityOfTokenSecondBuy = ""
    @State private var boughtPriceSecondBuy = ""

    var body: some View {
        ZStack {
            Color.yellow
                .ignoresSafeArea()

            VStack {
                TextField("Enter amount of token: first buy", text: $quantityOfTokenFirstBuy)
                    .textFieldClearButton(text: $quantityOfTokenFirstBuy)
                    .title
                    .focused($focus)

                TextField("Enter price: first buy", text: $boughtPriceFirstBuy)
                    .textFieldClearButton(text: $boughtPriceFirstBuy)
                    .title
                    .focused($focus)

                TextField("Enter amount of token: second buy", text: $quantityOfTokenSecondBuy)
                    .textFieldClearButton(text: $quantityOfTokenSecondBuy)
                    .title
                    .focused($focus)

                TextField("Enter price: second buy", text: $boughtPriceSecondBuy)
                    .textFieldClearButton(text: $boughtPriceSecondBuy)
                    .title
                    .focused($focus)

                Text("Your average price is:")
                    .foregroundColor(.black)
                    .padding(.bottom, -1)

                Text("\((averagePrice).formatted())$")
                    .foregroundColor(.black)

            }

            Button {
                quantityOfTokenFirstBuy = ""
                boughtPriceFirstBuy = ""
                quantityOfTokenSecondBuy = ""
                boughtPriceSecondBuy = ""
            } label: {
                Text("Clear")
                    .titleClear
            }
            .padding(.top, 500)
            .shadow(radius: 2)
        }
    }

    var averagePrice: Double {
        let totalQuantity: Double = (Double(convert(text: quantityOfTokenFirstBuy)) ?? 0) + (Double(convert(text: quantityOfTokenSecondBuy)) ?? 1)
        let v1 = (Double(convert(text: quantityOfTokenFirstBuy)) ?? 0) * (Double(convert(text: boughtPriceFirstBuy)) ?? 0)
        let v2 = (Double(convert(text: quantityOfTokenSecondBuy)) ?? 0) * (Double(convert(text: boughtPriceSecondBuy)) ?? 0)
        let totalValue = ( v1 + v2 ) * 1.001
        let averagePrice = (totalValue / totalQuantity)

        return averagePrice
    }

    func convert(text: String) -> String {
         text.replacingOccurrences(of: ",", with: ".")
    }
}

struct AveragePriceView_Previews: PreviewProvider {
    static var previews: some View {
        AveragePriceView()
    }
}
