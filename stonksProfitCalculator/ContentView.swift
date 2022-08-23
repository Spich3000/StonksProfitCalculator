//
//  ContentView.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 02.03.2022.

import SwiftUI
import MobileCoreServices

struct ContentView: View {
    
    // MARK: PROPERTIES
    @State private var selectedView = 1
    @StateObject var commission = CommissionRate()
    
    // MARK: BODY
    var body: some View {
        TabView(selection: $selectedView) {
            PortfolioView()
                .tabItem { labelPortfolio }.tag(1)
            SellPriceView(commission: commission)
                .tabItem { labelSellPrice }.tag(2)
            AveragePriceView(commission: commission)
                .tabItem { labelAveragePrice }.tag(3)
            DifferenceView()
                .tabItem { labelDifference }.tag(4)
            SettingsView(commission: commission)
                .tabItem { labelSettings }.tag(5)
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                doneButton
            }
        }
        .accentColor(Color("tabGray"))
    }
}

// MARK: PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ContentView(commission: CommissionRate())
                .environmentObject(dev.portfolioViewModel)
        }
    }
}

// MARK: VIEW COMPONENTS
extension ContentView {
    private var labelPortfolio: some View {
        Label("Portfolio", systemImage: "briefcase")
    }
    
    private var labelSellPrice: some View {
        Label("Sell price", systemImage: "dollarsign.circle")
    }
    
    private var labelAveragePrice: some View {
        Label("Average Price", systemImage: "chart.xyaxis.line")
    }
    
    private var labelDifference: some View {
        Label("Difference", systemImage: "align.vertical.bottom")
    }
    
    private var labelSettings: some View {
        Label("Settings", systemImage: "gear")
    }
    
    private var doneButton: some View {
        Button("Done") {
            UIApplication.shared.endEditing()
        }
    }
    
}
