//
//  PortfolioDataService.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 19.08.2022.
//

import Foundation
import CoreData
import UIKit

class PortfolioDataService {
    
    private let container: NSPersistentContainer
    private let containerName = "PortfolioContainer"
    private let entityName = "Portfolio"
    
    @Published var savedEntities: [Portfolio] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading Core Data \(error)")
            }
            self.getPortfolio()
        }
    }
    
    // MARK: PUBLIC
    
    func updatePortfolio(coin: CoinModel, amount: Double, boughtPrice: Double) {
        // Check if coin is already in portfolio
        /*
        if let entity = savedEntities.first(where: { savedEntity in
            return savedEntity.coinID == coin.id
        }) {
            
        }
         */
        
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount, boughtPrice: boughtPrice)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount, boughtPrice: boughtPrice)
        }
    }
    
    // MARK: PRIVATE
    
    private func getPortfolio() {
        let request = NSFetchRequest<Portfolio>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching portfolio Entities \(error)")
        }
    }
    
    private func add(coin: CoinModel, amount: Double, boughtPrice: Double) {
        let entity = Portfolio(context: container.viewContext)
        // Conver CoinModel to entity
        entity.coinID = coin.id
        entity.amount = amount
        entity.boughtPrice = boughtPrice

        // Save and reload portfolio
        applyChanges()
    }
    
    // Update amount of coin
    private func update(entity: Portfolio, amount: Double, boughtPrice: Double) {
        entity.amount = amount
        entity.boughtPrice = boughtPrice
        applyChanges()
    }
    
    private func delete(entity: Portfolio) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
    
}
