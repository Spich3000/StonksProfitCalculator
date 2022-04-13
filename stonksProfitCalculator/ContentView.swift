//
//  ContentView.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 02.03.2022.

import SwiftUI

import MobileCoreServices

struct ContentView: View {
    
    @State private var selectedView = 1
    
//    var commissionRate: Double
    
    var body: some View {
        
        TabView(selection: $selectedView) {
//            ZStack {
//                VStack{
            SellPriceView()
//            Text("\(commissionRate)")
//                }
//            }
                .tabItem {
                    Label("Sell price", systemImage: "dollarsign.circle")
                }
                .tag(1)
            
            AveragePriceView()
                .tabItem {
                    Label("Average Price", systemImage: "chart.xyaxis.line")
                }
                .tag(2)
            
            DifferenceView()
                .tabItem {
                    Label("Difference", systemImage: "align.vertical.bottom")
                }
                .tag(3)
                        
            SettingsView()
                .tabItem {
                    Label("About", systemImage: "info.circle")
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
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
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
