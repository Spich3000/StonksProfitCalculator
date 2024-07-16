//
//  PortfolioViewModel.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 18.08.2022.
//

import Foundation
import Combine
import UIKit

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
        print("Initializing PortfolioViewModel...")  // Debug statement
        printSavedCoins()  // Add this line
    }
    
    func printSavedCoins() {
        print("printSavedCoins called...")  // Debug statement
        portfolioDataService.$savedEntities
            .sink { savedEntities in
                print("Saved Coins:")
                if savedEntities.isEmpty {
                    print("No saved coins found.")
                } else {
                    for entity in savedEntities {
                        print("Coin ID: \(entity.coinID), Amount: \(entity.amount), Bought Price: \(entity.boughtPrice)")
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func addSubscribers() {
        // Combine coins and search subscriber (updates allCoins)
        $searchText
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
    
    private func mapAllCoinsToPortfolioCoins(
        allCoins: [CoinModel],
        portfolioEntities: [Portfolio]
    ) -> [CoinModel] {
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

import CoreData

struct EncodablePortfolio: Codable {
    var coinID: String?
    var amount: Double
    var boughtPrice: Double
}

extension PortfolioViewModel {
    func savePortfolioToJSON(completion: @escaping (Bool, URL?) -> Void) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        let encodablePortfolios = mapPortfolioToEncodable(portfolios: portfolioDataService.savedEntities)

        do {
            let data = try encoder.encode(encodablePortfolios)
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = documentDirectory.appendingPathComponent("portfolio.json")
                try data.write(to: fileURL)
                print("Saved to: \(fileURL.absoluteString)")
                completion(true, fileURL) // Call completion with true and the file URL on successful save
            } else {
                completion(false, nil) // Call completion with false and no URL if the URL could not be formed
            }
        } catch {
            print("Error saving portfolio to JSON: \(error.localizedDescription)")
            completion(false, nil) // Call completion with false and no URL on error
        }
    }

    func readPortfolioFromJSON() {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentDirectory.appendingPathComponent("portfolio.json")
            do {
                let data = try Data(contentsOf: fileURL)
                let decodedPortfolios = try JSONDecoder().decode([EncodablePortfolio].self, from: data)
                print("Read from file: \(decodedPortfolios)")
            } catch {
                print("Error reading portfolio from JSON: \(error.localizedDescription)")
            }
        }
    }
    
    func copyPortfolioToJSONToClipboard() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        let encodablePortfolios = mapPortfolioToEncodable(portfolios: portfolioDataService.savedEntities)

        do {
            let jsonData = try encoder.encode(encodablePortfolios)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                UIPasteboard.general.string = jsonString
                print("JSON copied to clipboard.")
            }
        } catch {
            print("Failed to copy portfolio to JSON: \(error)")
        }
    }
    
    func sharePortfolioFile(fileURL: URL) {
        // Ensure you run this on the main thread since it involves UI operations
        DispatchQueue.main.async {
            let activityVC = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
            // Present the view controller
            let rootVC = UIApplication.shared.windows.first?.rootViewController
            rootVC?.present(activityVC, animated: true, completion: nil)
        }
    }

    func mapPortfolioToEncodable(portfolios: [Portfolio]) -> [EncodablePortfolio] {
        return portfolios.map { portfolio in
            EncodablePortfolio(
                coinID: portfolio.coinID,
                amount: portfolio.amount,
                boughtPrice: portfolio.boughtPrice
            )
        }
    }
}
