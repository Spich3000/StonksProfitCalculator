//
//  ContentView.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 02.03.2022.

import SwiftUI

import MobileCoreServices

struct ContentView: View {
    
    @State private var selectedView = 1
        
    var body: some View {
        
        TabView(selection: $selectedView) {
            SellPriceView()
                .tabItem {
                  Label("Sell price", systemImage: "dollarsign.circle")
                }
                .tag(1)
            
            DifferenceView()
                .tabItem {
                    Label("Difference", systemImage: "align.vertical.bottom")
                }
                .tag(2)
            
            AveragePriceView()
                .tabItem {
                    Label("Average Price", systemImage: "chart.xyaxis.line")
                }
                .tag(3)
            
            SettingsView()
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
               .hideKeyboard
                }
                .foregroundColor(.yellow)
            }
        }
        .accentColor(.black)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ContentView()
        }
    }
}
