//
//  PortfolioViewModel.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 18.08.2022.
//

import Foundation
import Combine

class PortfolioViewModel: ObservableObject {
    
    //    @Published var statistics: [StatisticModel] = []
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    @Published var isLoading = false
    @Published var searchText: String = ""
    @Published var sortOption: SortOption = .holdings
    
    private let coinDataService = CoinDataService()
    //    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    enum SortOption {
        case rank,
             rankReversed,
             holdings,
             holdingsReversed,
             price,
             priceReversed
    }
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        // Sub just for coins
        /*
         dataService.$allCoins
         .sink { [weak self] (returnedCoins) in
         self?.allCoins = returnedCoins
         }
         .store(in: &cancellables)
         */
        
        // Combine coins and search subscriber (updates allCoins)
        $searchText
        // when allCoins is published code below is also running
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // Updates portfolioCoins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
        /*
         //            .map { (coinModels, portfolioEntities) -> [CoinModel] in
         //                coinModels
         //                    .compactMap { coin -> CoinModel? in
         //                        guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
         //                            return nil
         //                        }
         //                        return coin.updateHoldings(amount: entity.amount)
         //                    }
         //            }
         */
            .sink { [weak self] returnedCoins in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioIfNeeded(coins: returnedCoins)
                self.isLoading = false
                
            }
            .store(in: &cancellables)
        
        // Updates market data
        //        marketDataService.$marketData
        //            .combineLatest($portfolioCoins)
        //            .map(mapGlobalMArketData)
        //            .sink { [weak self] returnedStats in
        //                self?.statistics = returnedStats
        //                self?.isLoading = false
        //            }
        //            .store(in: &cancellables)
        
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        //        marketDataService.getData()
        HapticManager.notification(type: .success)
    }
    
    private func filterAndSortCoins(text: String, coins: [CoinModel], sort: SortOption) -> [CoinModel] {
        var filteredCoins = filterCoins(text: text, coins: coins)
        sortCoins(sort: sort, coins: &filteredCoins)
        return filteredCoins
    }
    
    // Func to clean our code Subscriber above
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        let lowercasedText = text.lowercased()
        
        return coins.filter { coin -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    private func sortCoins(sort: SortOption, coins: inout [CoinModel]) {
        switch sort {
        case .rank, .holdings:
            coins.sort(by: { $0.rank < $1.rank })
        case .rankReversed, .holdingsReversed:
            coins.sort(by: { $0.rank > $1.rank })
        case .price:
            coins.sort(by: { $0.currentPrice < $1.currentPrice })
        case .priceReversed:
            coins.sort(by: { $0.currentPrice > $1.currentPrice })
        }
    }
    
    private func sortPortfolioIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        switch sortOption {
        case .holdings:
            return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
        case .holdingsReversed:
            return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
        default:
            return coins
        }
    }
    
    private func mapAllCoinsToPortfolioCoins(allCoins: [CoinModel], portfolioEntities: [Portfolio]) -> [CoinModel] {
        allCoins
            .compactMap { coin -> CoinModel? in
                guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    
    //    private func mapGlobalMArketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
    //        var stats: [StatisticModel] = []
    //        guard let data = marketDataModel else {
    //            return stats
    //        }
    //        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
    //        let volume = StatisticModel(title: "24h Volume", value: data.volume)
    //        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
    //
    //        /*
    //        let portfolioValue = portfolioCoins.map { coin -> Double in
    //            return coin.currentHoldingsValue
    //        }
    //        */
    //        let portfolioValue =
    //        portfolioCoins
    //            .map({ $0.currentHoldingsValue })
    //            .reduce(0, +)
    //
    //        let previousValue =
    //        portfolioCoins
    //            .map { coin -> Double in
    //                let currentValue = coin.currentHoldingsValue
    //                let percentChange = coin.priceChangePercentage24H ?? 0 / 100
    //                let previousValue = currentValue / (1 + percentChange)
    //                return previousValue
    //            }
    //            .reduce(0, +)
    //
    //        let percentageChange = ((portfolioValue - previousValue) / previousValue)
    //
    //        let portfolio = StatisticModel(
    //            title: "Portfolio Value",
    //            value: portfolioValue.asCurrencyWith2Decimals(),
    //            percentageChange: percentageChange)
    //
    //        stats.append(contentsOf: [marketCap, volume, btcDominance, portfolio])
    //        return stats
    //    }
    
}
