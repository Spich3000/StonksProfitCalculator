//
//  AveragePriceView.swift
//  stonksProfitCalculator
//
//  Created by Nigel Gee on 20/03/2022.
//

import SwiftUI

struct AveragePriceView: View {
    @FocusState private var focus: Bool
    
    @State private var quantityOfTokenFirstBuy = 0.0
    @State private var boughtPriceFirstBuy = 0.0
    @State private var quantityOfTokenSecondBuy = 0.0
    @State private var boughtPriceSecondBuy = 0.0

    var body: some View {
        ZStack {
            Color.yellow
                .ignoresSafeArea()

            VStack(spacing: 2) {
                Text("Enter amount of token: first buy")
                TextField("Enter amount of token: first buy", value: $quantityOfTokenFirstBuy, format: .number)
                    .textFieldClearButton(for: $quantityOfTokenFirstBuy)
                    .title
                    .focused($focus)

                Text("Enter price: first buy")
                TextField("Enter price: first buy", value: $boughtPriceFirstBuy, format: .number)
                    .textFieldClearButton(for: $boughtPriceFirstBuy)
                    .title
                    .focused($focus)

                Text("Enter amount of token: second buy")
                TextField("Enter amount of token: second buy", value: $quantityOfTokenSecondBuy, format: .number)
                    .textFieldClearButton(for: $quantityOfTokenSecondBuy)
                    .title
                    .focused($focus)

                Text("Enter price: second buy")
                TextField("Enter price: second buy", value: $boughtPriceSecondBuy, format: .number)
                    .textFieldClearButton(for: $boughtPriceSecondBuy)
                    .title
                    .focused($focus)

                Text("Your average price is:")
                    .foregroundColor(.black)
                    .padding(.bottom, -1)

                Text("\(averagePrice, format: .currency(code: "USD"))")
                    .foregroundColor(.black)

            }

            Button {
                quantityOfTokenFirstBuy = 0
                boughtPriceFirstBuy = 0
                quantityOfTokenSecondBuy = 0
                boughtPriceSecondBuy = 0
            } label: {
                Text("Clear")
                    .titleClear
            }
            .padding(.top, 500)
            .shadow(radius: 2)
        }
    }

    var averagePrice: Double {
        let totalQuantity: Double = quantityOfTokenFirstBuy + quantityOfTokenSecondBuy
        let v1 = quantityOfTokenFirstBuy * boughtPriceFirstBuy
        let v2 = quantityOfTokenSecondBuy * boughtPriceSecondBuy
        let totalValue = ( v1 + v2 ) * 1.001
        let averagePrice = (totalValue / totalQuantity)
        
        guard averagePrice > 0 else { return 0}
        return averagePrice
    }
}

struct AveragePriceView_Previews: PreviewProvider {
    static var previews: some View {
        AveragePriceView()
    }
}
