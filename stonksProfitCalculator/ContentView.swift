//
//  ContentView.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 02.03.2022.

import SwiftUI

struct ContentView: View {
    @SceneStorage("selectedView") var selectedView = 1

    @FocusState private var focus: Bool

    var body: some View {
        TabView(selection: $selectedView) {
            SellPriceView()
                .tabItem {
                    Label("Sell Price", systemImage: "dollarsign.circle")
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
                Spacer()
                Button("Done") {
                    focus = false
                }
                .foregroundColor(.yellow)
            }
        }
        .accentColor(.black)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


