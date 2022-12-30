//
//  CoinLogoView.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 19.08.2022.
//

import SwiftUI

struct CoinLogoView: View {
    
    let coin: CoinModel
    
    var body: some View {
        VStack(spacing: 0) {
            CoinImageView(coin: coin)
                .frame(width: 40, height: 40)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
//            Text(coin.name)
//                .font(.caption)
//                .lineLimit(2)
//                .minimumScaleFactor(0.5)
//                .multilineTextAlignment(.center)
        }
    }
}

struct CoinLogoView_Previews: PreviewProvider {
    static var previews: some View {
        CoinLogoView(coin: dev.coin)
            .previewLayout(.sizeThatFits)
    }
}
