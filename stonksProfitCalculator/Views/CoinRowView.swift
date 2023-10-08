//
//  CoinRowView.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 19.08.2022.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                leftColumn
                Spacer()
                centerColumn
                rightColumn
            }
            .font(.subheadline)
            .frame(height: 50)
            .background(Color.black.opacity(0.00001))
        }
        .buttonStyle(SimpleButtonStyle())
    }
}

//MARK: VIEW COMPONENTS
extension CoinRowView {
    
    private var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .padding(.leading, 6)
        }
    }
    
    // MARK: CENTER COLUMN
    private var centerColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.boughtValue.asCurrencyWith2Decimals() + "$")
                .bold()
            Text((coin.currentHoldings ?? 0).asCurrencyWith6Decimals() + " " + coin.symbol.uppercased())
                .minimumScaleFactor(0.5)
                .lineLimit(1)
        }
    }
    
    // MARK: RIGHT COLUMN
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals() + "$")
                .bold()
            Text((coin.gain >= 0 ? "+" : "") + coin.gain.asCurrencyWith2DecimalsPortfolio() + "$")
                .foregroundColor(coin.gain >= 0 ? Color.green : Color.red)
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment:  .trailing)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: dev.coin) {}
                .previewLayout(.sizeThatFits)
            CoinRowView(coin: dev.coin) {}
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
