//
//  CoinRowView.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 19.08.2022.
//

import SwiftUI

struct CoinRowView: View {
    
    //MARK: PROPERTIES
    let coin: CoinModel
    
    //MARK: BODY
    var body: some View {
        HStack {
            leftColumn
            Spacer()
            centerColumn
            rightColumn
        }
        .font(.subheadline)
        // With background we can click at any place in the row and do tapGesture
        .background(Color(.clear))
    }
}

//MARK: PREVIEW
struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: dev.coin)
                .previewLayout(.sizeThatFits)
            CoinRowView(coin: dev.coin)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}

//MARK: VIEW COMPONENTS
extension CoinRowView {
    
    private var leftColumn: some View {
        HStack(spacing: 0.0) {
            Text("\(coin.rank)")
                .font(.caption)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
        }
    }
    
    private var centerColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.boughtValue.asCurrencyWith2Decimals() + "$")
                .bold()
            Text((coin.currentHoldings ?? 0).asCurrencyWith6Decimals() + " " + coin.symbol.uppercased())
        }
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith6Decimals() + "$")
                .bold()
            Text(coin.gain.asCurrencyWith2DecimalsPortfolio() + "$")
                .foregroundColor(coin.gain >= 0 ? Color.green : Color.red)
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment:  .trailing)
    }
}
