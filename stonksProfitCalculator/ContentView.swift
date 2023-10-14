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
        PortfolioView()
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    doneButton
                }
            }
            .accentColor(Color("tabGray"))
    }
    
    private var doneButton: some View {
        Button("Done") {
            UIApplication.shared.endEditing()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ContentView()
                .environmentObject(dev.portfolioViewModel)
        }
    }
}
