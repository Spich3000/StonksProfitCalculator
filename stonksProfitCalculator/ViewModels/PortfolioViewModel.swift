//
//  PortfolioViewModel.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 18.08.2022.
//

import Foundation
import Combine

class PortfolioViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    @Published var isLoading = false
    @Published var searchText: String = ""
    @Published var sortOption: SortOption = .holdings
    
    let coinDataService = CoinDataService()
    private let portfolioDataService = PortfolioDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    enum SortOption {
        case rank,
             rankReversed,
             holdings,
             holdingsReversed,
             boughtValue,
             boughtValueReversed
    }
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
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
            .sink { [weak self] returnedCoins in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioIfNeeded(coins: returnedCoins)
                self.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func updatePortfolio(
        coin: CoinModel,
        amount: Double,
        boughtPrice: Double
    ) {
        portfolioDataService.updatePortfolio(
            coin: coin,
            amount: amount,
            boughtPrice: boughtPrice)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
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
        default:
            coins.sort(by: { $0.rank < $1.rank })
        }
    }
    
    private func sortPortfolioIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        switch sortOption {
        case .holdings:
            return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
        case .holdingsReversed:
            return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
        case .rank:
            return coins.sorted(by: { $0.rank < $1.rank })
        case .rankReversed:
            return coins.sorted(by: { $0.rank > $1.rank })
        case .boughtValue:
            return coins.sorted(by: { $0.boughtValue > $1.boughtValue })
        case .boughtValueReversed:
            return coins.sorted(by: { $0.boughtValue < $1.boughtValue })
        }
    }
    
    private func mapAllCoinsToPortfolioCoins(allCoins: [CoinModel], portfolioEntities: [Portfolio]) -> [CoinModel] {
        allCoins
            .compactMap { coin -> CoinModel? in
                guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount, boughtPrice: entity.boughtPrice)
            }
    }
    
    var portfolioValue: Double {
        portfolioCoins.map({ $0.boughtValue }).reduce(0, +)
    }
    
    var currentPortfolioValue: Double {
        portfolioCoins.map({ $0.currentHoldingsValue }).reduce(0, +)
    }
    
    var portfolioGain: Double {
        currentPortfolioValue - portfolioValue
    }
    
    
}
