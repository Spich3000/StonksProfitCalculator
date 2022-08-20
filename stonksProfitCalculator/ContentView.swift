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
                .tabItem { Label("Portfolio", systemImage: "briefcase") }.tag(1)
            SellPriceView(commission: commission)
                .tabItem { Label("Sell price", systemImage: "dollarsign.circle") }.tag(2)
            AveragePriceView(commission: commission)
                .tabItem { Label("Average Price", systemImage: "chart.xyaxis.line") }.tag(3)
            DifferenceView()
                .tabItem { Label("Difference", systemImage: "align.vertical.bottom") }.tag(4)
            SettingsView(commission: commission)
                .tabItem { Label("Settings", systemImage: "gear") }.tag(5)
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
    private var doneButton: some View {
        Button("Done") {
            UIApplication.shared.endEditing()
        }
    }
    
}
