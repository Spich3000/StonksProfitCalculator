//
//  ContentView.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 02.03.2022.

import SwiftUI
import MobileCoreServices

struct ContentView: View {
    
    @State private var selectedView = 1
    @StateObject var commission = CommissionRate()
    
    var body: some View {
        TabView(selection: $selectedView) {
            
            SellPriceView(commission: commission)
                .tabItem {
                    Label("Sell price", systemImage: "dollarsign.circle")
                }
                .tag(1)
            
            AveragePriceView(commission: commission)
                .tabItem {
                    Label("Average Price", systemImage: "chart.xyaxis.line")
                }
                .tag(2)
            
            DifferenceView()
                .tabItem {
                    Label("Difference", systemImage: "align.vertical.bottom")
                }
                .tag(3)
            
            SettingsView(commission: commission)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(4)
        }
        .onAppear() {
            UITabBar.appearance().barTintColor = .gray
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    UIApplication.shared.endEditing()
                }
            }
        }
        .accentColor(Color("tabGray"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ContentView(commission: CommissionRate())
        }
    }
}
