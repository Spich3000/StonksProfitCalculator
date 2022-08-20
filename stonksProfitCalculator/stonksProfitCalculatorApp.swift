//
//  stonksProfitCalculatorApp.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 02.03.2022.
//

import SwiftUI

@main
struct stonksProfitCalculatorApp: App {
    
    @StateObject private var viewModel = PortfolioViewModel()
    
    init() {
        UITabBar.appearance().barTintColor = .gray
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
